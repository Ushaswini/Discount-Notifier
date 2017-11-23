using System;
using System.Collections.Generic;
using Android.App;
using Android.Views;
using Android.Widget;
using iBeaconPracticeApp.Models;
using FFImageLoading;

namespace iBeaconPracticeApp
{
    public class ProductsAdapter : BaseAdapter<Product>
    {
        protected Activity Context = null;
        protected List<Product> Products;

        public ProductsAdapter(Activity context, List<Product> products) : base()
        {
            this.Context = context;
            this.Products = products;
        }


        public override long GetItemId(int position)
        {
            return position;
        }

        public override int Count
        {
            get
            {
                return Products.Count;
            }
        }      

        public override Product this[int index]
        {
            get { return Products[index]; }
        }

        public override View GetView(int position, View convertView, ViewGroup parent)
        {
            ProductViewHolder holder = null;
            var view = convertView;

            if (view == null)
            {
                view = Context.LayoutInflater.Inflate(Resource.Layout.product_row, parent,false);

                holder = new ProductViewHolder();
                holder.Name =(TextView) view.FindViewById(Resource.Id.tv_name);
                holder.Price = (TextView)view.FindViewById(Resource.Id.tv_price);
                holder.Region = (TextView)view.FindViewById(Resource.Id.tv_region);
                holder.Discount = (TextView)view.FindViewById(Resource.Id.tv_discount);
                holder.ProductImage = (FFImageLoading.Views.ImageViewAsync)view.FindViewById(Resource.Id.imageView);
                

                view.Tag = holder;
            }
            else
            {
                holder = view.Tag as ProductViewHolder;
            }
            
            var item = Products[position];
            holder.Name.Text = item.Name;
            holder.Discount.Text = item.Discount;
            holder.Price.Text = Java.Lang.String.Format("{0:C}", item.Price);
            holder.Region.Text = item.Region;
            
            ImageService.Instance
                .LoadUrl(item.ImageUrl)
                .Success(() =>
                {
                    // your code here...
                })
                .Error((exception) => {
                    Console.Write(exception.Message);
                })
                .Into(holder.ProductImage);

            return view;
        }
       
        private class ProductViewHolder : Java.Lang.Object
        {
            public TextView Name { get; set; }
            public TextView Price { get; set; }
            public TextView Discount { get; set; }
            public TextView Region { get; set; }
            public FFImageLoading.Views.ImageViewAsync ProductImage { get; set; }
            
        }

        public void UpdateData(List<Product> products)
        {
            Products.Clear();
            Products.AddRange(products);
            this.NotifyDataSetChanged();
        }
    }
}