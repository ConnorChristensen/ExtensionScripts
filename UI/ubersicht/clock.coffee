stylingOptions =
    # background color
    background: 'rgba(#ffffff, 0.1)'

dateOptions =
    # format of 'date'
    date: '%d/%m/%Y %a'
    # format of 'weekDay'
    weekDay: '%a'

format = (->
    '%a %l:%M'
)()

command: 'date "+%a %H:%M" && echo "|" && cat ~/.cache/wal/colors.json'

# the refresh frequency in milliseconds
refreshFrequency: 30000

# for update function
dateOptions: dateOptions

render: (output) -> """
    <div id='simpleClock'>#{output}</div>
"""

update: (output) ->
    html = output.split('|')[0]
    color = JSON.parse(output.split('|')[1])
    $(simpleClock).html(html)
    $(simpleClock).css("color", color.colors.color9)

style: (->
    return """
    font-family: Helvetica Neue
    top: 5px
    width: 100%
    #simpleClock
        font-size: 2.7em
        font-weight: 200
        text-align: center
    """
)()
