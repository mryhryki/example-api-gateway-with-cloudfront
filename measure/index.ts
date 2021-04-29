const COUNT = 1

const getNowUnixTimeMs = (): number => (new Date()).getTime()
const getAverage = (results: number[]): number =>
  results.reduce((total, current) => total + current, 0) / COUNT

const measure = async (url: string, count: number): Promise<number[]> => {
  // Lambda のコールドスタートを考慮して、初回は計測対象にしない
  await fetch(url)
  console.log(`[Measure: ${url}]`)
  const results: number[] = []
  for await (const c of Array.from({length: count}).map((_, i) => i + 1)) {
    const start = getNowUnixTimeMs()
    const res = await fetch(url)
    const timeMs = getNowUnixTimeMs() - start
    const {random} = await res.json()
    results.push(timeMs)
    console.debug("Round[%d] Res:%d (%s ms) [%s]", c, res.status, timeMs, random)
  }
  return results;
}

const apiGatewayResults = await measure("https://r3hh44vkbc.execute-api.us-east-1.amazonaws.com/dev/example", COUNT)
const cloudFrontResults = await measure("https://d3kxy2u36xjgwi.cloudfront.net/example", COUNT)
console.log("API Gateway average response time:", getAverage(apiGatewayResults), "ms")
console.log("CloudFront average response time:", getAverage(cloudFrontResults), "ms")
