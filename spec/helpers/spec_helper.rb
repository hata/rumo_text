#
# This may be a hack.
# I don't want to write module name in spec files
# because these specs are used for this package only.
# And describe doesn't accept include.
#
class Object
  include RumoText
end
