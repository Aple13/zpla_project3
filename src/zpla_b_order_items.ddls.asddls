@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for Order Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_b_order_items
  as select from zpla_d_orderitem as OrderItems
{
  key orderitem_uuid        as OrderitemUuid,
      order_uuid            as OrderUuid,
      item_id               as ItemId,
      cart_qty              as CartQty,
      @Semantics.amount.currencyCode: 'Currency'
      cart_subtotal         as CartSubtotal,
      currency              as Currency,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.createdBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
