view: d_conversionValue {
  derived_table: {
    sql: select 'Conversion Value' as Conversion_Value, 'RC ' as RC
union ALL '1', '0.00109713190404027'
union all '2', '0.00264486414423989'
union all '3', '0.00489953324867769'
union all '4', '0.00786113921735365'
union all '5', '0.0115296820502677'
union all '6', '0.01590516174742'
union all '7', '0.0209875783088105'
union all '8', '0.0267769317344392'
union all '9', '0.033273222024306'
union all '10', '0.0404764491784109'
union all '11', '0.0483866131967541'
union all '12', '0.0570037140793354'
union all '13', '0.0663277518261549'
union all '14', '0.0763587264372125'
union all '15', '0.0870966379125084'
union all '16', '0.0985414862520424'
union all '17', '0.110693271455814'
union all '18', '0.123551993523824'
union all '19', '0.137117652456073'
union all '20', '0.15139024825256'
union all '21', '0.166369780913284'
union all '22', '0.182056250438247'
union all '23', '0.198449656827449'
union all '24', '0.215550000080888'
union all '25', '0.233357280198565'
union all '26', '0.251871497180481'
union all '27', '0.271092651026635'
union all '28', '0.291020741737027'
union all '29', '0.311655769311657'
union all '30', '0.332997733750526'
union all '31', '0.355046635053632'
union all '32', '0.377802473220977'
union all '33', '0.40126524825256'
union all '34', '0.425434960148381'
union all '35', '0.45031160890844'
union all '36', '0.475895194532737'
union all '37', '0.502185717021273'
union all '38', '0.529183176374046'
union all '39', '0.556887572591058'
union all '40', '0.585298905672308'
union all '41', '0.614417175617797'
union all '42', '0.644242382427523'
union all '43', '0.674774526101487'
union all '44', '0.70601360663969'
union all '45', '0.737959624042131'
union all '46', '0.77061257830881'
union all '47', '0.803972469439727'
union all '48', '0.838039297434883'
union all '49', '0.872813062294276'
union all '50', '0.908293764017908'
union all '51', '0.944481402605778'
union all '52', '0.981375978057886'
union all '53', '1.28664194290987'
union all '54', '1.92459744014765'
union all '55', '2.69189616022148'
union all '56', '3.58853810313135'
union all '57', '4.61452326887728'
union all '58', '5.76985165745925'
union all '59', '7.05452326887728'
union all '60', '8.46853810313135'
union all '61', '10.0118961602214'
union all '62', '11.6845974401476'
union all '63', '13.48664194'
    ;;
  }
dimension: ConversionValue {
  type: number
  sql: ${TABLE}.conversion_value ;;
}

  measure: RC {
    type: number
    sql: ${TABLE}.RC ;;
  }

}
