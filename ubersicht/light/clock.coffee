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
    return """
    color: #000
    font-family: Helvetica Neue
    top: 5px
    width: 100%
    #simpleClock
        font-size: 2.4em
        font-weight: 100
        text-align: center
    """
)()
