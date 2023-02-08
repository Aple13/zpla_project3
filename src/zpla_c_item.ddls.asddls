@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for Item'
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity zpla_c_item
  as projection on zpla_i_item
{
      @Search.defaultSearchElement: true
  key ItemId,
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{  entity: { name: 'zpla_b_category', element:    'CategoryId' } }]
      @EndUserText.label: 'Category'
      @ObjectModel.text.element: ['CategoryName']
      @UI.textArrangement: #TEXT_ONLY
      CategoryId,
      CategoryName,
      ItemName,
      ItemDescription,
      @Semantics.amount.currencyCode: 'Currency'
      ItemPrice,
      Currency,
      ItemQty,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */
      _ItemT
}
