<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Franchise Direct Scraper API by Piloterr – scrape Franchise Direct data as JSON" width="100%"></a>
</p>

# Franchise Direct Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Franchise Direct Scraper API** lets you extract public data from Franchise Direct as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Franchise Direct Franchise API** — Read one Franchise Direct profile: cash requirement, franchise fee, investment range, and training.
- **Franchise Direct Search API** — Search Franchise Direct listings by keyword or listing URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Franchise Direct Franchise API](#franchise-direct-franchise-api) | `/v2/franchisedirect/franchise` | 1 | Read one Franchise Direct profile |
| [Franchise Direct Search API](#franchise-direct-search-api) | `/v2/franchisedirect/search` | 1 | Search Franchise Direct listings by keyword or listing URL. Each card includes a USD cash figure and a numeric minimum. |

## Table of contents

- [How it works](#how-it-works)
- [Franchise Direct Franchise API](#franchise-direct-franchise-api)
- [Franchise Direct Search API](#franchise-direct-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Franchise Direct Franchise API

Read one Franchise Direct profile: cash requirement, franchise fee, investment range, and training.

`GET | POST https://api.piloterr.com/v2/franchisedirect/franchise` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. A Franchise Direct profile URL from search, or the same path beginning with /. A keyword or a listing URL returns 400. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/franchisedirect/franchise",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.franchisedirect.com/coffee-franchises/coffeenow",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type FranchiseDirectFranchise = {
  url?: string;
  name?: string;
  image?: string;
  industry?: string;
  description?: string;
  business_type?: string;
  franchise_fee?: number;
  training_provided?: boolean;
  available_locations?: string;
  financing_assistance?: string;
  total_investment_max?: number;
  total_investment_min?: number;
  franchise_fee_display?: string;
  minimum_cash_required?: number;
  total_investment_display?: string;
  minimum_cash_required_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.franchisedirect.com/coffee-franchises/coffeenow",
});

const response = await fetch(`https://api.piloterr.com/v2/franchisedirect/franchise?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as FranchiseDirectFranchise;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/franchisedirect/franchise
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.franchisedirect.com/coffee-franchises/coffeenow"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "url": "https://www.franchisedirect.com/coffee-franchises/coffeenow",
  "name": "CoffeeNow",
  "image": "https://static4.franchisedirect.ie/dims4/default/234c6dc/2147483647/strip/true/crop/350x220+0+0/resize/270x170!/quality/95/?url=https%3A%…",
  "industry": "Coffee Franchises",
  "description": "Bring the coffee shop experience directly to local workplaces with a technology-driven mobile franchise that eliminates the need for a tr…",
  "business_type": "Franchise",
  "franchise_fee": 25000,
  "training_provided": true,
  "available_locations": "Single-unit opportunities available throughout the US, EXCLUDING: CA, HI, IL, IN, MD, MI, MN, NY, ND, RI, SD, VA, WA, WI.",
  "financing_assistance": "None",
  "total_investment_max": 309000,
  "total_investment_min": 133000,
  "franchise_fee_display": "$25,000",
  "minimum_cash_required": 60000,
  "total_investment_display": "$133,000 - $309,000",
  "minimum_cash_required_display": "$60,000"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `name` | string |  |
| `image` | string |  |
| `industry` | string |  |
| `description` | string |  |
| `business_type` | string |  |
| `franchise_fee` | integer |  |
| `training_provided` | boolean |  |
| `available_locations` | string |  |
| `financing_assistance` | string |  |
| `total_investment_max` | integer |  |
| `total_investment_min` | integer |  |
| `franchise_fee_display` | string |  |
| `minimum_cash_required` | integer |  |
| `total_investment_display` | string |  |
| `minimum_cash_required_display` | string |  |

## Franchise Direct Search API

Search Franchise Direct listings by keyword or listing URL. Each card includes a USD cash figure and a numeric minimum.

`GET | POST https://api.piloterr.com/v2/franchisedirect/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. A keyword, or a Franchise Direct listing URL (search, directory, or category). A profile URL such as /coffee-franchises/coffeenow returns 400 on this endpoint. Send that URL to /v2/franchisedirect/franchise. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/franchisedirect/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "coffee",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type FranchiseDirectSearch = {
  results?: {
    url?: string;
    name?: string;
    image?: string;
    category?: string;
    description?: string;
    minimum_cash_required?: number;
    minimum_cash_required_display?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "coffee",
});

const response = await fetch(`https://api.piloterr.com/v2/franchisedirect/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as FranchiseDirectSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/franchisedirect/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "coffee"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.franchisedirect.com/coffee-franchises/coffeenow",
      "name": "CoffeeNow",
      "image": "https://static4.franchisedirect.ie/dims4/default/5f4574f/2147483647/strip/true/crop/350x220+0+0/resize/255x160!/quality/95/?url=https%3A%…",
      "category": "Coffee Franchises",
      "description": "Bring the coffee shop experience directly to local workplaces with a technology-driven mobile franchise that eliminates the need for a tr…",
      "minimum_cash_required": 60000,
      "minimum_cash_required_display": "$60,000"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 6,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].image` | string |  |
| `results[].category` | string |  |
| `results[].description` | string |  |
| `results[].minimum_cash_required` | integer |  |
| `results[].minimum_cash_required_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Franchise | Search |
|---|---|---|
| cURL (Bash) | [`franchise`](examples/curl/franchise.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`franchise`](examples/php/franchise.php) | [`search`](examples/php/search.php) |
| C# | [`franchise`](examples/csharp/Franchise.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`franchise`](examples/go/franchise.go) | [`search`](examples/go/search.go) |
| Java | [`franchise`](examples/java/FranchiseExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`franchise`](examples/ruby/franchise.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`franchise`](examples/nodejs/franchise.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Franchise Direct plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Franchise Direct?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/franchisedirect/franchise` **1**, `/v2/franchisedirect/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Franchise Direct API return?

Each endpoint returns structured JSON: **Franchise Direct Franchise** — `url`, `name`, `image`, `industry`, `description`, `business_type`; **Franchise Direct Search** — `results[]`, `results[].url`, `results[].name`, `results[].image`, `results[].category`, `results[].description`.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Franchise Direct is a trademark of its respective owner. This repository is not affiliated with or endorsed by Franchise Direct. Examples are released under the MIT license.</sub>
