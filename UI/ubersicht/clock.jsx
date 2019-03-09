// Command format info:
// %a: Day of week (abbreviated)
// %H: hour (24)
// %l: hour (12)
// %M: minute (leading zero)
// more info by running `man date` in terminal
export const command = 'date "+%a %H:%M" && echo "|" && cat ~/.cache/wal/colors.json'
export const refreshFrequency = 10000
export const render = ({ output, dispatch }) => {
	output = output.split("|")
   const time = output[0]
   const color = JSON.parse(output[1]).colors.color9
   const style = {
      color: color,
      fontFamily: "Helvetica Neue",
      top: "5px",
      width: "100vw",
      fontSize: "40px",
      fontWeight: "200",
      textAlign: "center"
   }

   return <div style={style}>{time}</div>
}
