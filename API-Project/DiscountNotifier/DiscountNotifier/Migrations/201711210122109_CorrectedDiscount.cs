namespace DiscountNotifier.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CorrectedDiscount : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Discounts", "OfferText", c => c.String());
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Discounts", "OfferText", c => c.Int(nullable: false));
        }
    }
}
