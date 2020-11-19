# view: SKAdNetwork_Test {
#   derived_table: {
#     explore_source: events {
#       column: created_date {}
#       column: event {}
#       column: conversion_value {}
#       column: advertising_id {}
#       filters: {
#         field: events.created_date
#         value: "2020/10/30 to 2020/11/15"
#       }
#       filters: {
#         field: events.event
#         value: "skadnetwork4-conversion"
#       }
#       filters: {
#         field: events.platform
#         value: "ios"
#       }
#     }
#   }
#   dimension: created_date {
#     type: date
#   }
#   dimension: event {}
#   dimension: conversion_value {
#     type: number
#   }
#   dimension: advertising_id {}
# }
