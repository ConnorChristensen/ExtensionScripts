# Attributions:
# The svg path for the bolt icon provided by Open Iconic
# The source code is available at https://github.com/iconic/open-iconic

# command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $2,$3,$4 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"
command: "pmset -g batt && echo '|' && cat ~/.cache/wal/colors.json"

refreshFrequency: 10000

render: -> """
  <svg version="3.1" id="battery"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    viewBox="0 0 120 28" >
    <defs>
      <clipPath id="cut-off-left">
        <rect x="107" y="0" width="10" height="100" />
      </clipPath>
    </defs>
    <rect id="hull" x="1" y="1" rx="3" ry="3" width="104" height="26" />
    <rect id="charge" x="3" y="3" rx="2" ry="2" height="22" />
  </svg>
"""

update: (output, domEl) ->

  output = output.split('|')

  chargingInfo = output[0].split('\t')[1].split(';')
  charge = parseInt(chargingInfo[0].replace('%', ''))
  text = $('#text')

  colors = JSON.parse(output[1]);
  if charge <= 25
    fill = '250,'+ 8 * charge + ',0'
    fill = 'rgba('+fill+',1)'
  else
    fill = colors.colors.color9

  $('#charge').attr('width',charge)
  $('#charge').css('fill',fill)
  text.text(charge + '%')
  $('#hull').css('stroke', colors.colors.color9)



style: """
    color: main
    scale = .55
    opacity = 1.0

    top: 15px
    right: 5px
    font-family: Helvetica Neue
    font-size: 1em * scale

    svg
      width: 220px * scale
      height: auto
      margin: 0
      opacity: opacity

    #hull
      fill: none
      stroke-width: 1

    #tip
      fill: main

    #charge
      stroke-width: 2

    #text
      font-weight: bold
      fill: main

    #bolt
      position: absolute
      fill: main
      height: 25px
"""
