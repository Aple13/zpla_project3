@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for Item text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_b_item_t
  as select from zpla_d_item_t as ItemT

  association [0..1] to I_Language as _Language on $projection.Langu = _Language.Language
{
  key item_id          as ItemId,
  key langu            as Langu,
      category_id      as CategoryId,
      item_name        as ItemName,
      item_description as ItemDescription,
      last_changed_at  as LastChangedAt,
      
      _Language
}
