const args = process.argv.slice(2).sort((i, j) => i.length > j.length)

// Can do a check to see if there are actually any arguments at all

function lcp(acc, arr, i) {
  const ele = arr[0][i] && arr[0][i].toLowerCase()
  if(ele && arr.reduce((match, str) => match && str[i].toLowerCase() === ele, ele)) return lcp(acc + ele, arr, i+1)
  console.log(acc )
}
lcp('', args, 0)