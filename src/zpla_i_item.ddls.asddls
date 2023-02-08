@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpla_i_item
  as select from zpla_b_item as Item

  association [0..1] to zpla_i_item_t as _ItemT on  $projection.ItemId = _ItemT.ItemId
                                                and _ItemT.Langu       = $session.system_language

{
  key ItemId,
      _ItemT.CategoryId      as CategoryId,
      _ItemT.CategoryName    as CategoryName,
      _ItemT.ItemName        as ItemName,
      _ItemT.ItemDescription as ItemDescription,
      @Semantics.amount.currencyCode: 'Currency'
      ItemPrice,
      Currency,
      ItemQty,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      _ItemT
}
