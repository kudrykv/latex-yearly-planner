import puppeteer from 'puppeteer';

const [absoluteHtmlFilePath, outputFilePath] = process.argv.slice(-2);

const browser = await puppeteer.launch();
const page = await browser.newPage();

await page.goto(absoluteHtmlFilePath);

await page.pdf({
    path: outputFilePath,
    preferCSSPageSize: true
});

await browser.close();
