const path = require('path')
const { exec } = require('child_process')

const extensions = ['.html', '.css', '.js', '.jsx', '.vue']

module.exports = (event, filePath) => {
  for (let extension of extensions) {
    if (filePath.endsWith(extension) && event === 'update') {
      exec(`prettier --write "${path.join(process.cwd(), filePath)}"`)
    }
  }
}
