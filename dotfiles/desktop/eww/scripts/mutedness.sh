# amixer get Master | awk 'BEGIN { ORS=""; print "{" }
#      /Front Left/ && /\[on\]/ { left="true" }
#      /Front Left/ && !/\[on\]/ { left="false" }
#      /Front Right/ && /\[on\]/ { right="true" }
#      /Front Right/ && !/\[on\]/ { right="false" }
#      END { print "left: " left ", right: " right "}"}'

export JSON | amixer get Master | awk 'BEGIN { ORS=""; print "{" }
     /Front Left/ && /\[on\]/ { left="true" }
     /Front Left/ && !/\[on\]/ { left="false" }
     /Front Right/ && /\[on\]/ { right="true" }
     /Front Right/ && !/\[on\]/ { right="false" }
     END { print "\"left\": \"" left "\", \"right\": \"" right "\"}"; print "\n"}'

echo $JSON
