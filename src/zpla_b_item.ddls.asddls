@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for Item text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_b_item
  as select from zpla_d_item as Item

  association [0..1] to I_Currency as _Currency on $projection.Currency = _Currency.Currency
{
  key item_id         as ItemId,
      @Semantics.amount.currencyCode: 'Currency'
      item_price      as ItemPrice,
      currency        as Currency,
      item_qty        as ItemQty,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,

      _Currency
}
