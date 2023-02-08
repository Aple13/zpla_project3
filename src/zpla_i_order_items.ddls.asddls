@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS fo Order Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_i_order_items
  as select from zpla_b_order_items as OrderItems
  
  association to parent zpla_i_order as _Order on $projection.OrderUuid = _Order.OrderUuid
  
  association [1] to zpla_i_item     as _Item  on $projection.ItemId    = _Item.ItemId
{
  key OrderitemUuid,
      OrderUuid,
      ItemId,
      CartQty,
      @Semantics.amount.currencyCode: 'Currency'
      CartSubtotal,
      Currency,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.createdBy: true
      LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      
      _Order,
      _Item
}
