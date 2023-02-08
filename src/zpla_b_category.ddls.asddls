@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for item category'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS

define view entity zpla_b_category
  as select from zpla_d_categoryt as Category

  association [0..1] to I_Language as _Language on $projection.Langu = _Language.Language
{
  key langu         as Langu,
      @ObjectModel.text.element: ['ItemCategory']
  key category_id   as CategoryId,
      item_category as ItemCategory,

      _Language
}
