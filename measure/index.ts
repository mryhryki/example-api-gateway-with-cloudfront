const COUNT = 100

const getNowUnixTimeMs = (): number => (new Date()).getTime()
const getAverage = (results: number[]): number =>
  results.reduce((total, current) => total + current, 0) / COUNT

const measure = async (url: string, count: number): Promise<number[]> => {
  // Lambda のコールドスタートを考慮して、初回は計測対象にしない
  await fetch(url)
  console.log("URL[%s]", url)
  const results: number[] = []
  for await (const c of Array.from({length: count}).map((_, i) => i + 1)) {
    const start = getNowUnixTimeMs()
    const res = await fetch(url)
    const timeMs = getNowUnixTimeMs() - start
    const {lambda, random} = await res.json()
    results.push(timeMs)
    console.log("%s Res: %d (%s ms) [Lambda: %s, Random: %s]", `00${c}`.substr(-3, 3), res.status, timeMs, lambda, random)
  }
  console.log("")
  return results;
}

console.log("")
const {api_gateway_url, cloudfront_url} = JSON.parse(await Deno.readTextFile('./terraform.tfstate')).outputs
const apiGatewayResults = await measure(api_gateway_url.value, COUNT)
const cloudFrontResults = await measure(cloudfront_url.value, COUNT)
console.log("API Gateway average response time:", getAverage(apiGatewayResults), "ms")
console.log("CloudFront average response time:", getAverage(cloudFrontResults), "ms")
console.log("")
