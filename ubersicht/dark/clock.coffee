stylingOptions =
    # background color
    background: 'rgba(#ffffff, 0.1)' 
    # show fullscreen -> true
    fullscreen: false

dateOptions =
    # display not only 'time' also 'date'
    showDate: false
    # format of 'date'
    date: '%d/%m/%Y %a'

format = (->
    if dateOptions.showDate
        dateOptions.date + '\n' +'%l:%M'
    else
        '%l:%M'
)()

command: "date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

# for update function
dateOptions: dateOptions

render: (output) -> """
    <div id='simpleClock'>#{output}</div>
"""

update: (output) ->
    html = output

    $(simpleClock).html(html)

style: (->
    width = 'auto'
    transform = 'auto'

    if stylingOptions.fullscreen
        fontSize = '10em'
        width = '94%'

    return """
    color: #ffffff
    font-family: Helvetica Neue
    right: 2%
    top: 2%
    transform: #{transform}
    width: #{width}

    #simpleClock
        font-size: 3em
        font-weight: 100
        margin: 0
        text-align: center
    """
)()
