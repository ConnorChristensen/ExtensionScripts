command: 'date "+%H:%M" && echo "|" && cat ~/.cache/wal/colors.json'

# the refresh frequency in milliseconds
refreshFrequency: 30000

render: (output) -> """
    <div id='minuteClock'>#{output}</div>
"""

update: (output) ->
    html = output.split('|')[0]
    color = JSON.parse(output.split('|')[1])
    hours = html.split(':')[0]
    minutes = html.split(':')[1]
    totalMinutes = (hours * 60) + parseInt(minutes)
    $(minuteClock).html(totalMinutes)
    $(minuteClock).css("color", color.colors.color9)

style: (->
    return """
    font-family: Helvetica Neue
    top: 5px
    left: 10px
    #minuteClock
        font-size: 2.7em
        font-weight: 100
        text-align: center
        text-shadow: 1px 1px 3px black
    """
)()
