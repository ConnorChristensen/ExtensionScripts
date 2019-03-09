// Attributions:
// The svg path for the bolt icon provided by Open Iconic
// The source code is available at https://github.com/iconic/open-iconic
import {css} from "uebersicht"
export const command = "pmset -g batt && echo '|' && cat ~/.cache/wal/colors.json"
export const refreshFrequency = 100000
export const className = {
    color: "white",
    top: "10px",
    left: "5px",
    svg: {
       width: "120px",
       height: "auto",
       margin: "0"
   }
}

const bolt = css({
   position: "absolute",
   fill: "white",
   opacity: ".7"
})

export const render = ({ output }) => {
   output = output.split('|')

   const colors = JSON.parse(output[1]);
   const chargingInfo = output[0].split('\t')[1].split(';');
   const charging = chargingInfo[1].trim();
   const percent = chargingInfo[0].replace('%', '');

   const charge = {
      strokeWidth: "2",
      fill: colors.colors.color9
   }
   const hull = {
       fill: "none",
       stroke: colors.colors.color9,
       strokeWidth: "1",
       opacity: ".7"
   }

   return <svg version="3.1" id="battery" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 28">
        <rect style={hull} x="1" y="1" rx="3" ry="3" width="104" height="26" />
        <rect style={charge} width={percent} x="3" y="3" rx="2" ry="2" height="22" />
        {(charging === "charging" || charging === "charged") ? <path className={bolt} d="M3 0l-3 5h2v3l3-5h-2v-3z" transform="translate(50,6), scale(2)" /> : null}
    </svg>
}
