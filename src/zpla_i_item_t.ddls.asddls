@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for item text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpla_i_item_t
  as select from zpla_b_item_t as ItemT

  association [0..1] to zpla_b_category    as _Category on  $projection.CategoryId = _Category.CategoryId
                                                        and _Category.Langu        = $session.system_language
{
  key ItemId,
  key Langu,
      CategoryId,
      _Category.ItemCategory as CategoryName,
      ItemName,
      ItemDescription,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */
      _Language,
      _Category
}
