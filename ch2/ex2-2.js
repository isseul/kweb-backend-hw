const { executionAsyncResource } = require("async_hooks");
const fs = require("fs");
const path = require("path");
const util = require("util");

const readDir = util.promisify(fs.readdir);
const getStat = util.promisify(fs.stat);

const PATH = "./test";

const searchDirectory = async (dir) => {
  const filelist = await readDir(dir);
  filelist.forEach(async (file) => {
    const filepath = path.join(dir, file);
    const filestat = await getStat(filepath);
    if (filestat.isDirectory()) await searchDirectory(filepath);
    else if (path.extname(filepath) === ".js") console.log(filepath);
  });
};

(async () => {
  try {
    await searchDirectory(PATH);
  } catch (err) {
    console.error(err);
  }
})();
