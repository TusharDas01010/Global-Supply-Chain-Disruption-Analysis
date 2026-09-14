# Global-Supply-Chain-Disruption-Analysis
# SQL Analytics Portfolio Project | 2015–2026

𝐏𝐫𝐨𝐣𝐞𝐜𝐭 𝐎𝐯𝐞𝐫𝐯𝐢𝐞𝐰 
Global supply chains are exposed to geopolitical events, transportation delays, port congestion, commodity price fluctuations and changing freight costs. This project analyzes supply chain data from 2015 to 2026 to identify high-risk trade routes, resilient countries, operational disruptions, cost pressures and changes in global trade performance.

The objective is not only to analyze historical data, but also to convert the analysis into 𝐛𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐢𝐧𝐬𝐢𝐠𝐡𝐭𝐬 𝐭𝐡𝐚𝐭 𝐜𝐚𝐧 𝐬𝐮𝐩𝐩𝐨𝐫𝐭 𝐬𝐮𝐩𝐩𝐥𝐲 𝐜𝐡𝐚𝐢𝐧 𝐫𝐢𝐬𝐤 𝐦𝐚𝐧𝐚𝐠𝐞𝐦𝐞𝐧𝐭 𝐚𝐧𝐝 𝐬𝐭𝐫𝐚𝐭𝐞𝐠𝐢𝐜 𝐝𝐞𝐜𝐢𝐬𝐢𝐨𝐧-𝐦𝐚𝐤𝐢𝐧𝐠.

---


## 🎥 Video Presentation

A complete video walkthrough of the project, covering the business problem, data analysis, key insights, SQL analysis, and Power BI dashboard.

[▶️ Watch the Full Project Presentation](https://youtu.be/4ZCIjNGC0Yw)

---

𝐁𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐏𝐫𝐨𝐛𝐥𝐞𝐦
Global supply chain managers need to answer several important questions:

● Which trade routes are most exposed to disruption?

● Which countries have stronger supply chain resilience?

● How are geopolitical events affecting freight costs?

● Which routes are experiencing increasing costs despite declining trade volumes?

● Where are commodity stress and trade volume declines occurring together?

● Which routes can be considered safer alternatives during disruptions?

● How is supply chain performance changing over time?

● This project addresses these questions using SQL-based data analysis.

---

𝐁𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐎𝐛𝐣𝐞𝐜𝐭𝐢𝐯𝐞𝐬
The analysis focuses on five major objectives:

● 𝐓𝐫𝐚𝐝𝐞 𝐏𝐞𝐫𝐟𝐨𝐫𝐦𝐚𝐧𝐜𝐞: Understand changes in trade volume and freight costs over time.

● 𝐑𝐢𝐬𝐤 𝐈𝐝𝐞𝐧𝐭𝐢𝐟𝐢𝐜𝐚𝐭𝐢𝐨𝐧: Identify routes with high geopolitical, congestion and delay risks.

● 𝐑𝐞𝐬𝐢𝐥𝐢𝐞𝐧𝐜𝐞 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬: Compare countries and trade routes based on their ability to withstand disruptions.

● 𝐂𝐨𝐬𝐭 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬: Identify routes where logistics costs are increasing despite weaker trade volumes.

● 𝐌𝐚𝐧𝐚𝐠𝐞𝐦𝐞𝐧𝐭 𝐃𝐞𝐜𝐢𝐬𝐢𝐨𝐧 𝐒𝐮𝐩𝐩𝐨𝐫𝐭: Convert analytical results into practical supply chain recommendations.

---

𝐃𝐚𝐭𝐚𝐬𝐞𝐭 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚 𝐌𝐨𝐝𝐞𝐥

### `commodity_market`
Contains historical commodity prices and the Commodity Stress Index.

### `country_metadata`
Contains country-level economic and logistics information such as GDP per capita, trade dependency, logistics performance and port capacity.

### `geopolitical_events`
Contains geopolitical events, their severity, affected regions, duration and associated risk increase.

### `trade_routes`
Contains information about international trade routes, including origin, destination, distance, shipping method and route type.

### `weekly_route_operations`
Contains weekly operational information including trade volume, shipping delays, freight costs, port congestion, geopolitical risk, route status and carbon emissions.

### `weekly_timeline`
Provides the weekly date dimension used for time-based analysis.

---

𝐀𝐧𝐚𝐥𝐲𝐭𝐢𝐜𝐚𝐥 𝐀𝐩𝐩𝐫𝐨𝐚𝐜𝐡

The project follows a structured analytics process:

𝐃𝐚𝐭𝐚 → 𝐒𝐐𝐋 𝐓𝐫𝐚𝐧𝐬𝐟𝐨𝐫𝐦𝐚𝐭𝐢𝐨𝐧 → 𝐊𝐏𝐈 𝐂𝐚𝐥𝐜𝐮𝐥𝐚𝐭𝐢𝐨𝐧 → 𝐑𝐢𝐬𝐤 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬 → 𝐁𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐈𝐧𝐬𝐢𝐠𝐡𝐭𝐬 → 𝐑𝐞𝐜𝐨𝐦𝐦𝐞𝐧𝐝𝐚𝐭𝐢𝐨𝐧𝐬

SQL was used to combine the datasets, calculate KPIs, compare time periods, rank routes and build analytical indices.

The analysis includes:

● Aggregations
● Joins
● CTEs
● Window Functions
● LAG()
● Moving averages
● Cumulative calculations
● Year-over-year growth
● Ranking
● Conditional analysis
● Route-level analysis
● Risk scoring
● Resilience scoring
● Health scoring

---

𝐊𝐞𝐲 𝐊𝐏𝐈𝐬

The project tracks several important supply chain KPIs:

𝐓𝐫𝐚𝐝𝐞 𝐕𝐨𝐥𝐮𝐦𝐞

Measures the total quantity of goods transported.

𝐅𝐫𝐞𝐢𝐠𝐡𝐭 𝐂𝐨𝐬𝐭

Measures transportation and logistics costs.

𝐅𝐫𝐞𝐢𝐠𝐡𝐭 𝐂𝐨𝐬𝐭 𝐩𝐞𝐫 𝐓𝐨𝐧𝐧𝐞

Measures transportation cost relative to trade volume.

𝐒𝐡𝐢𝐩𝐩𝐢𝐧𝐠 𝐃𝐞𝐥𝐚𝐲

Measures operational delays across trade routes.

𝐏𝐨𝐫𝐭 𝐂𝐨𝐧𝐠𝐞𝐬𝐭𝐢𝐨𝐧

Measures the level of congestion at ports.

𝐆𝐞𝐨𝐩𝐨𝐥𝐢𝐭𝐢𝐜𝐚𝐥 𝐑𝐢𝐬𝐤

Measures exposure to geopolitical disruptions.

𝐂𝐨𝐦𝐦𝐨𝐝𝐢𝐭𝐲 𝐒𝐭𝐫𝐞𝐬𝐬

Measures pressure from commodity market conditions.

𝐂𝐚𝐫𝐛𝐨𝐧 𝐄𝐦𝐢𝐬𝐬𝐢𝐨𝐧𝐬

Measures transportation-related emissions.

𝐑𝐨𝐮𝐭𝐞 𝐑𝐢𝐬𝐤 𝐒𝐜𝐨𝐫𝐞

Combines geopolitical risk, port congestion and shipping delay.

𝐑𝐨𝐮𝐭𝐞 𝐑𝐞𝐬𝐢𝐥𝐢𝐞𝐧𝐜𝐞 𝐒𝐜𝐨𝐫𝐞

Evaluates the relative strength of trade routes.

𝐒𝐮𝐩𝐩𝐥𝐲 𝐂𝐡𝐚𝐢𝐧 𝐇𝐞𝐚𝐥𝐭𝐡 𝐈𝐧𝐝𝐞𝐱

Combines multiple operational factors to classify routes as Healthy, Stable, At Risk or Critical.

---

𝐊𝐞𝐲 𝐅𝐢𝐧𝐝𝐢𝐧𝐠𝐬

One of the most important findings is that global trade volume remained relatively stable for much of the period, but 2026 experienced a significant decline. Trade volume decreased by 𝟓.𝟐𝟒% 𝐢𝐧 𝟐𝟎𝟐𝟔, while freight costs increased by 𝟐𝟒.𝟎𝟕%. This indicates a strong divergence between trade activity and transportation costs.

Rail had the highest average freight cost among the analyzed shipping methods, followed by road, air and sea.

The analysis also identified 𝐄𝐧𝐞𝐫𝐠𝐲 as the largest trade route category by total trade volume, followed by Consumer Goods, Agriculture, Technology and Manufacturing.

The 𝐂𝐲𝐛𝐞𝐫 𝐀𝐭𝐭𝐚𝐜𝐤 𝐞𝐯𝐞𝐧𝐭 𝐨𝐧 𝐉𝐮𝐧𝐞 𝟒, 𝟐𝟎𝟐𝟔 showed the strongest observed freight-cost impact in the event analysis, with freight costs increasing by approximately 𝟒𝟎.𝟗𝟗% in the defined post-event window.

Several routes emerged as high-risk based on the project's composite risk methodology. 𝐑𝟎𝟎𝟎𝟒𝟑, 𝐀𝐮𝐬𝐭𝐫𝐚𝐥𝐢𝐚 𝐭𝐨 𝐆𝐞𝐫𝐦𝐚𝐧𝐲, recorded the highest risk score at 𝟔𝟔.𝟐𝟓.

The country resilience analysis also showed significant differences between countries. India recorded the highest resilience score in the project's custom methodology, while several developed economies showed weaker scores because of the combination of logistics, port and trade-dependency factors used in the model.

---

𝐇𝐢𝐠𝐡-𝐑𝐢𝐬𝐤 𝐑𝐨𝐮𝐭𝐞 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬

The project identifies routes where multiple risk factors are elevated.

The highest-risk routes include:

𝐑𝟎𝟎𝟎𝟒𝟑: Australia → Germany

𝐑𝟎𝟎𝟎𝟑𝟕: Canada → Germany

𝐑𝟎𝟎𝟎𝟒𝟒: Brazil → Canada

𝐑𝟎𝟎𝟎𝟐𝟎: France → Japan

𝐑𝟎𝟎𝟎𝟑𝟐: Japan → Brazil

The purpose of this analysis is to help supply chain managers prioritize routes requiring closer monitoring, contingency planning or alternative sourcing.

---

𝐑𝐨𝐮𝐭𝐞 𝐑𝐞𝐬𝐢𝐥𝐢𝐞𝐧𝐜𝐞 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬

A separate resilience score is used to identify routes that may provide stronger alternatives during disruption.

This creates an important business use case:

𝐇𝐢𝐠𝐡-𝐫𝐢𝐬𝐤 𝐫𝐨𝐮𝐭𝐞 → 𝐈𝐝𝐞𝐧𝐭𝐢𝐟𝐲 𝐫𝐞𝐬𝐢𝐥𝐢𝐞𝐧𝐭 𝐚𝐥𝐭𝐞𝐫𝐧𝐚𝐭𝐢𝐯𝐞 𝐫𝐨𝐮𝐭𝐞 → 𝐑𝐞𝐝𝐮𝐜𝐞 𝐝𝐢𝐬𝐫𝐮𝐩𝐭𝐢𝐨𝐧 𝐞𝐱𝐩𝐨𝐬𝐮𝐫𝐞

Instead of only reporting which routes are risky, the analysis attempts to answer the more valuable management question:

"𝐖𝐡𝐚𝐭 𝐜𝐚𝐧 𝐰𝐞 𝐮𝐬𝐞 𝐚𝐬 𝐚𝐧 𝐚𝐥𝐭𝐞𝐫𝐧𝐚𝐭𝐢𝐯𝐞?"

That makes the project more decision-oriented.

---

𝐒𝐮𝐩𝐩𝐥𝐲 𝐂𝐡𝐚𝐢𝐧 𝐇𝐞𝐚𝐥𝐭𝐡 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬

The Supply Chain Health Index combines:

● Trade Volume

● Shipping Delay

● Freight Cost

● Commodity Stress

● Port Congestion

Routes are classified into:

𝐇𝐞𝐚𝐥𝐭𝐡𝐲, 𝐒𝐭𝐚𝐛𝐥𝐞, 𝐀𝐭 𝐑𝐢𝐬𝐤, 𝐂𝐫𝐢𝐭𝐢𝐜𝐚𝐥

This allows management to quickly identify routes that require immediate attention instead of reviewing dozens of individual KPIs.

---

𝐆𝐞𝐨𝐩𝐨𝐥𝐢𝐭𝐢𝐜𝐚𝐥 𝐄𝐱𝐩𝐨𝐬𝐮𝐫𝐞

The project also evaluates country-level geopolitical exposure by considering:

𝐓𝐫𝐚𝐝𝐞 𝐃𝐞𝐩𝐞𝐧𝐝𝐞𝐧𝐜𝐲 × 𝐀𝐯𝐞𝐫𝐚𝐠𝐞 𝐄𝐯𝐞𝐧𝐭 𝐒𝐞𝐯𝐞𝐫𝐢𝐭𝐲

The analysis identified France, the US, Australia, Brazil and Canada among the countries with the highest calculated geopolitical exposure.

---

𝐁𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐑𝐞𝐜𝐨𝐦𝐦𝐞𝐧𝐝𝐚𝐭𝐢𝐨𝐧𝐬

The analysis leads to several management recommendations.

𝐏𝐫𝐢𝐨𝐫𝐢𝐭𝐢𝐳𝐞 𝐡𝐢𝐠𝐡-𝐫𝐢𝐬𝐤 𝐫𝐨𝐮𝐭𝐞𝐬: Routes with consistently high geopolitical risk, congestion and delays should receive additional monitoring.

𝐃𝐞𝐯𝐞𝐥𝐨𝐩 𝐚𝐥𝐭𝐞𝐫𝐧𝐚𝐭𝐢𝐯𝐞 𝐫𝐨𝐮𝐭𝐞𝐬: Resilient routes can be evaluated as potential alternatives when high-risk routes experience disruption.

𝐌𝐨𝐧𝐢𝐭𝐨𝐫 𝐜𝐨𝐬𝐭-𝐯𝐨𝐥𝐮𝐦𝐞 𝐝𝐢𝐯𝐞𝐫𝐠𝐞𝐧𝐜𝐞: Increasing freight costs combined with declining trade volume should be treated as an early warning signal.

𝐒𝐭𝐫𝐞𝐧𝐠𝐭𝐡𝐞𝐧 𝐜𝐨𝐧𝐭𝐢𝐧𝐠𝐞𝐧𝐜𝐲 𝐩𝐥𝐚𝐧𝐧𝐢𝐧𝐠: Major geopolitical events can create sudden increases in logistics costs, so businesses should maintain alternative transportation and sourcing options.

𝐒𝐭𝐫𝐞𝐧𝐠𝐭𝐡𝐞𝐧 𝐜𝐨𝐧𝐭𝐢𝐧𝐠𝐞𝐧𝐜𝐲 𝐩𝐥𝐚𝐧𝐧𝐢𝐧𝐠: Periods of elevated commodity stress combined with declining trade volume can indicate increasing supply chain pressure.

𝐓𝐫𝐚𝐜𝐤 𝐨𝐩𝐞𝐫𝐚𝐭𝐢𝐨𝐧𝐚𝐥 𝐡𝐞𝐚𝐥𝐭𝐡: The Supply Chain Health Index can be used as a management dashboard to prioritize routes requiring intervention.

This helps identify countries where supply chain disruption could potentially have a larger business impact.
