import { $ } from "bun";

const args = Bun.argv

if (args.length < 3) {
  console.log('Missing package argument: eg (bun npmUpgrade nuxt)')
  process.exit(1)
}

function match(text: string, regex: RegExp) {
  const matches = text.match(regex)
  if (matches) {
    return Array.from(matches)
  }
  return []
}

const npmPackage = args[2]
const res = await $`ncu -u ${npmPackage}`
const semverRegex = /\d+\.\d+\.\d+/g
const [previousVersion, currentVersion] = match(res.text(), semverRegex)


// TODO: figure out how to call NVM use
// const useRes = await $`$(brew --prefix nvm)/nvm.sh use`

await $`npm install`
await $`git add .`
await $`git commit -m "chore(web): bump ${npmPackage} from ${previousVersion} to ${currentVersion}"`
