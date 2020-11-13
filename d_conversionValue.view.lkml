view: d_conversionValue {
  derived_table: {
    sql: select 'Conversion Value' as conversion_value, 'RC ' as RC
union select '1', '0.00109713190404027'
union select '2', '0.00264486414423989'
union select '3', '0.00489953324867769'
union select '4', '0.00786113921735365'
union select '5', '0.0115296820502677'
union select '6', '0.01590516174742'
union select '7', '0.0209875783088105'
union select '8', '0.0267769317344392'
union select '9', '0.033273222024306'
union select '10', '0.0404764491784109'
union select '11', '0.0483866131967541'
union select '12', '0.0570037140793354'
union select '13', '0.0663277518261549'
union select '14', '0.0763587264372125'
union select '15', '0.0870966379125084'
union select '16', '0.0985414862520424'
union select '17', '0.110693271455814'
union select '18', '0.123551993523824'
union select '19', '0.137117652456073'
union select '20', '0.15139024825256'
union select '21', '0.166369780913284'
union select '22', '0.182056250438247'
union select '23', '0.198449656827449'
union select '24', '0.215550000080888'
union select '25', '0.233357280198565'
union select '26', '0.251871497180481'
union select '27', '0.271092651026635'
union select '28', '0.291020741737027'
union select '29', '0.311655769311657'
union select '30', '0.332997733750526'
union select '31', '0.355046635053632'
union select '32', '0.377802473220977'
union select '33', '0.40126524825256'
union select '34', '0.425434960148381'
union select '35', '0.45031160890844'
union select '36', '0.475895194532737'
union select '37', '0.502185717021273'
union select '38', '0.529183176374046'
union select '39', '0.556887572591058'
union select '40', '0.585298905672308'
union select '41', '0.614417175617797'
union select '42', '0.644242382427523'
union select '43', '0.674774526101487'
union select '44', '0.70601360663969'
union select '45', '0.737959624042131'
union select '46', '0.77061257830881'
union select '47', '0.803972469439727'
union select '48', '0.838039297434883'
union select '49', '0.872813062294276'
union select '50', '0.908293764017908'
union select '51', '0.944481402605778'
union select '52', '0.981375978057886'
union select '53', '1.28664194290987'
union select '54', '1.92459744014765'
union select '55', '2.69189616022148'
union select '56', '3.58853810313135'
union select '57', '4.61452326887728'
union select '58', '5.76985165745925'
union select '59', '7.05452326887728'
union select '60', '8.46853810313135'
union select '61', '10.0118961602214'
union select '62', '11.6845974401476'
union select '63', '13.48664194'
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
