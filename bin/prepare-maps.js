#!/usr/bin/env node
// Make executable: chmod +x ./bin/prepare-maps.js
// Usage: ./bin/prepare-maps.js
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const MAPS_DIR = path.join(__dirname, "../public/maps");

function getMapJson(basename) {
  const mapJsonPath = path.join(MAPS_DIR, `${basename}.json`);

  if (!fs.existsSync(mapJsonPath)) {
    console.log(`${mapJsonPath} does not exist!`);
    return;
  }
  const raw = fs.readFileSync(mapJsonPath);
  return JSON.parse(raw);
}

function sortMapJsonByValue(json) {
  const sortedObj = {};
  const sortedKeys = Object.keys(json).sort((a, b) => {
    if (json[a] < json[b]) {
      return -1;
    }
  });
  sortedKeys.forEach((key) => {
    sortedObj[key] = json[key];
  });

  return sortedObj;
}

function convertMapJsonToHtml(json) {
  let html = `<ul class="svg-hover-map-list">\n`;
  for (const [key, value] of Object.entries(json)) {
    html += `  <li data-map="${key}">${value}</li>\n`;
  }
  html += `</ul>`;

  return html;
}

// eslint-disable-next-line no-undef
const basenames = ["africa", "cn", "de", "europe", "gb", "ru", "us", "world"];

basenames.forEach((basename) => {
  const mapJsonParsed = getMapJson(basename);
  const sortedMapJson = sortMapJsonByValue(mapJsonParsed);
  // console.log(JSON.stringify(sortedMapJson, null, 2));
  const html = convertMapJsonToHtml(sortedMapJson);

  const mapHtmlPath = path.join(MAPS_DIR, `${basename}.json.html`);
  try {
    fs.writeFileSync(mapHtmlPath, html);
    console.log(`${mapHtmlPath} was written.`);
  } catch (err) {
    console.error(err);
  }
});
