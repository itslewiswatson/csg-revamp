local showroomVehicles = { 
-- LS SLOW
{ 458, 2161.1000976563, -1196.9000244141, 23.799999237061, 0, 0, 90 },
{ 489, 2160.8999023438, -1192.4000244141, 24.200000762939, 0, 0, 90 },
{ 445, 2160.3000488281, -1186.9000244141, 23.799999237061, 0, 0, 90 },
{ 467, 2160.5, -1172.6999511719, 23.700000762939, 0, 0, 90 },
{ 426, 2160.8000488281, -1168.4000244141, 23.60000038147, 0, 0, 90 },
{ 507, 2160.3999023438, -1182.1999511719, 23.799999237061, 0, 0, 90 },
{ 547, 2160.3000488281, -1177.1999511719, 23.700000762939, 0, 0, 90 },
{ 585, 2161, -1157.9000244141, 23.5, 0, 0, 90 },
{ 405, 2148.6999511719, -1157.4000244141, 23.799999237061, 0, 0, 270 },
{ 587, 2160.5, -1163.0999755859, 23.60000038147, 0, 0, 90 },
{ 466, 2160.8999023438, -1152.9000244141, 23.799999237061, 0, 0, 90 },
{ 492, 2149.5, -1134.0999755859, 25.5, 0, 0, 270 },
{ 566, 2149.1000976563, -1194.3000488281, 23.700000762939, 0, 0, 270 },
{ 546, 2148.8999023438, -1166.0999755859, 23.700000762939, 0, 0, 270 },
{ 551, 2149.3000488281, -1143.0999755859, 24.89999961853, 0, 0, 270 },
{ 421, 2160.8999023438, -1147.8000488281, 24.39999961853, 0, 0, 90 },
{ 516, 2136.1999511719, -1135.5, 25.60000038147, 0, 0, 38 },
{ 529, 2136.1999511719, -1131.1999511719, 25.39999961853, 0, 0, 38 },
{ 602, 2149, -1189.5999755859, 23.700000762939, 0, 0, 270 },
{ 545, 2160.8000488281, -1143.4000244141, 24.799999237061, 0, 0, 90 },
{ 496, 2149.1000976563, -1138.5, 25.299999237061, 0, 0, 270 },
{ 517, 2148.8000488281, -1161.6999511719, 23.799999237061, 0, 0, 270 },
{ 401, 2149.1000976563, -1170.9000244141, 23.60000038147, 0, 0, 270 },
{ 410, 2148.8000488281, -1152.5999755859, 23.700000762939, 0, 0, 270 },
{ 518, 2149, -1147.6999511719, 24.299999237061, 0, 0, 270 },
{ 600, 2148.8999023438, -1198.9000244141, 23.700000762939, 0, 0, 270 },
{ 527, 2149, -1203.1999511719, 23.60000038147, 0, 0, 270 },
{ 436, 2136.1999511719, -1127.3000488281, 25.39999961853, 0, 0, 38 },
{ 589, 2136.1999511719, -1139.6999511719, 25.10000038147, 0, 0, 38 },
{ 580, 2106.8000488281, -1195.8000488281, -6.1999998092651 },
{ 580, 2136.1999511719, -1144.1999511719, 24.799999237061, 0, 0, 38 },
{ 419, 2148.8000488281, -1180.4000244141, 23.799999237061, 0, 0, 270 },
{ 439, 2148.8999023438, -1184.9000244141, 23.799999237061, 0, 0, 270 },
{ 533, 2149.1999511719, -1175.9000244141, 23.60000038147, 0, 0, 270 },
{ 549, 2117, -1155.3000488281, 24.10000038147, 0, 0, 328 },
{ 491, 2117.6000976563, -1145.3000488281, 24.60000038147, 0, 0, 328 },
{ 474, 2151.8000488281, -1129.5, 25.5, 0, 0, 230 },
{ 536, 2119.5, -1128.3000488281, 25.200000762939, 0, 0, 327.99621582031 },
{ 575, 2117, -1150.5, 24.10000038147, 0, 0, 328 },
{ 534, 2162.6000976563, -1130, 25.39999961853, 0, 0, 230 },
{ 567, 2119.6999511719, -1123.3000488281, 25.39999961853, 0, 0, 328 },
{ 535, 2119.1999511719, -1133.5, 25.10000038147, 0, 0, 328 },
{ 576, 2135.6999511719, -1148.9000244141, 24.10000038147, 0, 0, 38 },
{ 412, 2118.8999023438, -1138.9000244141, 25, 0, 0, 328 },
-- LV SLOW
{ 458, 1742.1999511719, 1941.5999755859, 10.800000190735, 0, 0, 230 },
{ 489, 1742.3000488281, 1932.1999511719, 11.199999809265, 0, 0, 230 },
{ 445, 1731.1999511719, 1966.4000244141, 10.800000190735, 0, 0, 115 },
{ 467, 1742.5999755859, 1927.1999511719, 10.699999809265, 0, 0, 230 },
{ 426, 1742.1999511719, 1923.0999755859, 10.60000038147, 0, 0, 230 },
{ 507, 1731, 1893.8000488281, 10.800000190735, 0, 0, 115 },
{ 547, 1741.5, 1884, 10.699999809265, 0, 0, 230 },
{ 585, 1741.8000488281, 1902.3000488281, 10.5, 0, 0, 230 },
{ 405, 1741.8000488281, 1910.8000488281, 10.800000190735, 0, 0, 230 },
{ 587, 1742.0999755859, 1914.9000244141, 10.60000038147, 0, 0, 230 },
{ 466, 1741.6999511719, 1897.5999755859, 10.699999809265, 0, 0, 230 },
{ 492, 1742, 1936.6999511719, 10.699999809265, 0, 0, 230 },
{ 566, 1741.9000244141, 1960.5, 10.699999809265, 0, 0, 230 },
{ 546, 1742.6999511719, 1955.1999511719, 10.699999809265, 0, 0, 230 },
{ 551, 1741.9000244141, 1945.9000244141, 10.699999809265, 0, 0, 230 },
{ 421, 1741.9000244141, 1951.4000244141, 10.800000190735, 0, 0, 230 },
{ 529, 1742.3000488281, 1970.0999755859, 10.60000038147, 0, 0, 230 },
{ 602, 1741.5999755859, 1906.8000488281, 10.699999809265, 0, 0, 230 },
{ 545, 1741.5, 1919.3000488281, 10.800000190735, 0, 0, 230 },
{ 496, 1741.5, 1888.1999511719, 10.60000038147, 0, 0, 230 },
{ 517, 1741.5, 1892.5999755859, 10.800000190735, 0, 0, 230 },
{ 401, 1731.5, 1898.0999755859, 10.699999809265, 0, 0, 115 },
{ 410, 1731.5999755859, 1901.9000244141, 10.60000038147, 0, 0, 115 },
{ 518, 1731.8000488281, 1905.8000488281, 10.60000038147, 0, 0, 115 },
{ 600, 1731.4000244141, 1909.8000488281, 10.699999809265, 0, 0, 115 },
{ 527, 1731.6999511719, 1913.6999511719, 10.60000038147, 0, 0, 115 },
{ 436, 1731.4000244141, 1917.1999511719, 10.699999809265, 0, 0, 115 },
{ 589, 1731.8000488281, 1921.4000244141, 10.5, 0, 0, 115 },
{ 580, 1731.0999755859, 1925.4000244141, 10.699999809265, 0, 0, 115 },
{ 580, 1731, 1929.9000244141, 10.699999809265, 0, 0, 115 },
{ 419, 1731.9000244141, 1974.4000244141, 10.800000190735, 0, 0, 115 },
{ 439, 1731.5999755859, 1934.8000488281, 10.800000190735, 0, 0, 115 },
{ 533, 1732.0999755859, 1939.0999755859, 10.60000038147, 0, 0, 115 },
{ 549, 1731.5, 1942.5999755859, 10.699999809265, 0, 0, 115 },
{ 491, 1741.8000488281, 1975, 10.699999809265, 0, 0, 230 },
{ 474, 1731.6999511719, 1950.4000244141, 10.699999809265, 0, 0, 115 },
{ 536, 1731.3000488281, 1970.0999755859, 10.699999809265, 0, 0, 115 },
{ 575, 1731.3000488281, 1957.9000244141, 10.60000038147, 0, 0, 115 },
{ 534, 1731.6999511719, 1962.3000488281, 10.60000038147, 0, 0, 115 },
{ 567, 1742.1999511719, 1965.5, 10.800000190735, 0, 0, 230 },
{ 535, 1731, 1954, 10.699999809265, 0, 0, 115 },
{ 576, 1731.4000244141, 1884.0999755859, 10.60000038147, 0, 0, 115 },
{ 412, 1730.5, 1888.8000488281, 10.800000190735, 0, 0, 115 },
-- SF SLOW
{ 458, -1981.4000244141, 306.39999389648, 35.099998474121, 0, 0, 145 },
{ 489, -1977.8000488281, 306, 35.5, 0, 0, 145 },
{ 445, -1973.5999755859, 306.39999389648, 35.200000762939, 0, 0, 145 },
{ 467, -1982.5999755859, 241.80000305176, 35 },
{ 426, -1969.8000488281, 306.29998779297, 35, 0, 0, 145 },
{ 507, -1945, 271.5, 41, 0, 0, 114 },
{ 547, -1988.3000488281, 301.60000610352, 35, 0, 0, 244 },
{ 585, -1963.1999511719, 300.20001220703, 35.200000762939, 0, 0, 168 },
{ 405, -1956.4000244141, 271.10000610352, 41, 0, 0, 302.99914550781 },
{ 587, -1956.5999755859, 264.89999389648, 40.900001525879, 0, 0, 303 },
{ 466, -1956.1999511719, 261.39999389648, 41, 0, 0, 302.99987792969 },
{ 492, -1952.9000244141, 294, 40.900001525879, 0, 0, 4 },
{ 566, -1955.3000488281, 304.39999389648, 40.900001525879, 0, 0, 296 },
{ 546, -1956.3000488281, 257.60000610352, 40.900001525879, 0, 0, 303 },
{ 551, -1992.9000244141, 246.39999389648, 35.200000762939, 0, 0, 230 },
{ 421, -1953.9000244141, 280, 35.5, 0, 0, 176 },
{ 529, -1944.6999511719, 255.5, 40.799999237061, 0, 0, 114 },
{ 602, -1961.6999511719, 268.39999389648, 35.400001525879, 0, 0, 326.47509765625 },
{ 545, -1944, 258.79998779297, 41, 0, 0, 114 },
{ 496, -1952.5999755859, 257.20001220703, 35.299999237061, 0, 0, 270 },
{ 517, -1962.0999755859, 281.10000610352, 35.400001525879, 0, 0, 316 },
{ 401, -1944.3000488281, 262, 40.900001525879, 0, 0, 114 },
{ 410, -1961.9000244141, 272.20001220703, 35.200000762939, 0, 0, 318.99975585938 },
{ 518, -1962.4000244141, 260.39999389648, 35.299999237061, 0, 0, 0.9970703125 },
{ 600, -1944.5999755859, 267.70001220703, 40.900001525879, 0, 0, 114 },
{ 527, -1945.3000488281, 265.10000610352, 35.299999237061, 0, 0, 176.99981689453 },
{ 436, -1958.0999755859, 256.60000610352, 35.299999237061, 0, 0, 88.984375 },
{ 589, -1990.8000488281, 266.70001220703, 34.900001525879, 0, 0, 230 },
{ 580, -1946.4000244141, 271, 35.400001525879, 0, 0, 206.99926757813 },
{ 580, -1946.5, 258.5, 35.400001525879, 0, 0, 115 },
{ 419, -1945.5999755859, 275.39999389648, 41, 0, 0, 114 },
{ 439, -1962.4000244141, 285.20001220703, 35.5, 0, 0, 315 },
{ 533, -1952.1999511719, 295.39999389648, 35.299999237061, 0, 0, 182.99993896484 },
{ 549, -1956.8000488281, 304.60000610352, 35.299999237061, 0, 0, 84.999877929688 },
{ 491, -1987.5999755859, 305.39999389648, 35.099998474121, 0, 0, 244 },
{ 474, -1986.0999755859, 241.80000305176, 35.200000762939 },
{ 536, -1991.6999511719, 254.89999389648, 35.200000762939, 0, 0, 230 },
{ 575, -1991.5, 258.70001220703, 34.900001525879, 0, 0, 230 },
{ 534, -1993.5, 242.5, 35, 0, 0, 230.98248291016 },
{ 567, -1990.3000488281, 270.70001220703, 35.200000762939, 0, 0, 230.98718261719 },
{ 535, -1992.5, 251.10000610352, 35, 0, 0, 230.98266601563 },
{ 576, -1989.4000244141, 274.70001220703, 34.900001525879, 0, 0, 230.98205566406 },
{ 412, -1990.6999511719, 262.20001220703, 35.099998474121, 0, 0, 230.98620605469 },
-- LS INDUS
{ 499, 2290.6000976563, -2340.3000488281, 13.60000038147, 0, 0, 45 },
{ 588, 2298.8999023438, -2334.1999511719, 13.5, 0, 0, 45 },
{ 403, 2265.3000488281, -2332, 14.199999809265, 0, 0, 189.99774169922 },
{ 498, 2288.1999511719, -2343.5, 13.800000190735, 0, 0, 45 },
{ 514, 2272.8999023438, -2324.6000976563, 14.199999809265, 0, 0, 189.99774169922 },
{ 524, 2268.8999023438, -2327.8999023438, 14.60000038147, 0, 0, 189.99755859375 },
{ 423, 2295.1000976563, -2336, 13.699999809265, 0, 0, 45 },
{ 532, 2303.3999023438, -2340.3999023438, 14.699999809265, 0, 0, 190 },
{ 414, 2282.8999023438, -2361.8999023438, 13.699999809265, 0, 0, 189.99774169922 },
{ 578, 2307.1000976563, -2303.3000488281, 14.300000190735, 0, 0, 169 },
{ 443, 2322.8000488281, -2317.3999023438, 14.300000190735, 0, 0, 169.99969482422 },
{ 486, 2260.3000488281, -2336.3999023438, 13.800000190735, 0, 0, 189.99774169922 },
{ 515, 2277, -2320.6999511719, 14.699999809265, 0, 0, 189.99755859375 },
 -- TRACKTOR { 531, 2318.1000976563, -2362.6999511719, 13.60000038147, 0, 0, 349 },
{ 573, 2295.3999023438, -2383.3000488281, 13.800000190735, 0, 0, 349.99145507813 },
{ 456, 2301.6000976563, -2298.3000488281, 13.800000190735, 0, 0, 167.99884033203 },
{ 455, 2281.3999023438, -2317.3999023438, 14.10000038147, 0, 0, 189.99755859375 },
{ 530, 2325.1999511719, -2357.3999023438, 13.300000190735, 0, 0, 349.99169921875 },
{ 444, 2284.1999511719, -2350.5, 13, 0, 0, 44 },
{ 556, 2276.1000976563, -2357.8999023438, 13, 0, 0, 44 },
{ 557, 2280.6000976563, -2353.1999511719, 13, 0, 0, 43.9951171875 },
{ 568, 2322.1999511719, -2361, 13.5, 0, 0, 349.99169921875 },
{ 552, 2289.3999023438, -2355.1000976563, 13.300000190735, 0, 0, 190 },
{ 431, 2317.8000488281, -2312.6000976563, 13.800000190735, 0, 0, 169.99645996094 },
{ 438, 2295.1999511719, -2349, 13.699999809265, 0, 0, 190 },
 -- TOWTRUCK { 525, 2298.3000488281, -2346.6999511719, 13.5, 0, 0, 190 },
{ 437, 2313.6000976563, -2308.1999511719, 13.800000190735, 0, 0, 170 },
{ 572, 2322, -2356.3999023438, 13.199999809265, 0, 0, 349.99169921875 },
{ 582, 2307, -2372.1000976563, 13.699999809265, 0, 0, 349.99145507813 },
{ 413, 2303.3000488281, -2375.6999511719, 13.699999809265, 0, 0, 349.99169921875 },
{ 440, 2315.1000976563, -2364.6999511719, 13.800000190735, 0, 0, 349.99145507813 },
{ 459, 2311.1999511719, -2367.6000976563, 13.699999809265, 0, 0, 349.99169921875 },
{ 400, 2292.5, -2352.6000976563, 13.699999809265, 0, 0, 190 },
{ 442, 2286.1000976563, -2358.1999511719, 13.5, 0, 0, 189.99884033203 },
{ 482, 2299.6999511719, -2379.1999511719, 13.800000190735, 0, 0, 349.99145507813 },
{ 495, 2291.46, -2387, 13.54, 0, 0, 349.99145507813 },
-- SF INDUS
{ 499, -1936.1999511719, -2458.6999511719, 30.89999961853, 0, 0, 40 },
{ 588, -1950.2998046875, -2468.5, 30.990001678467, 0, 0, 39.995727539063 },
{ 403, -1979.9000244141, -2435.8000488281, 31.299999237061, 0, 0, 190 },
{ 498, -1944.69921875, -2466.2998046875, 31.200000762939, 0, 0, 39.995727539063 },
{ 514, -1985, -2431.6000976563, 31.299999237061, 0, 0, 190 },
{ 524, -1962.4000244141, -2439.3999023438, 31.700000762939, 0, 0, 189.99755859375 },
{ 423, -1980, -2454.3994140625, 30.700000762939, 0, 0, 350 },
{ 532, -1970, -2432.6999511719, 31.700000762939, 0, 0, 190 },
{ 414, -1957.0999755859, -2443.6000976563, 30.799999237061, 0, 0, 189.99755859375 },
{ 578, -1942.0999755859, -2460.6999511719, 31.60000038147, 0, 0, 40 },
{ 443, -1934.1999511719, -2449.6999511719, 31.39999961853, 0, 0, 160 },
{ 486, -2063.8999023438, -2445.3000488281, 43.200000762939 },
{ 486, -2000.8000488281, -2414.8999023438, 30.89999961853, 0, 0, 190 },
{ 515, -1990.4000244141, -2427.1000976563, 31.799999237061, 0, 0, 190 },
 -- TRACKTOR { 531, -1952.5999755859, -2474.1000976563, 30.60000038147, 0, 0, 40 },
{ 573, -2008.4000244141, -2428.6999511719, 30.799999237061, 0, 0, 350 },
{ 456, -2011.5999755859, -2425.8000488281, 30.89999961853, 0, 0, 349.99609375 },
{ 455, -1995.5, -2420.8999023438, 31.200000762939, 0, 0, 190 },
{ 530, -2013.6999511719, -2422.1000976563, 30.39999961853, 0, 0, 349.99609375 },
{ 444, -1972.4000244141, -2462.1000976563, 30.799999237061, 0, 0, 350 },
{ 556, -1976.3000488281, -2457.8000488281, 30.700000762939, 0, 0, 350 },
{ 557, -1968.8000488281, -2465.6999511719, 30.799999237061, 0, 0, 350 },
{ 568, -2017.4000244141, -2419.5, 30.60000038147, 0, 0, 349.99609375 },
{ 552, -1991.6999511719, -2444.1999511719, 30.39999961853, 0, 0, 349.99621582031 },
{ 431, -1939.0999755859, -2443.3000488281, 30.89999961853, 0, 0, 160 },
{ 438, -1985.4000244141, -2449.8000488281, 30.799999237061, 0, 0, 350 },
-- TOWTRUCK { 525, -2004.9000244141, -2411.1999511719, 30.60000038147, 0, 0, 189.99780273438 },
{ 437, -1944.3000488281, -2437.8000488281, 30.89999961853, 0, 0, 160 },
{ 572, -2015.3000488281, -2420.3999023438, 30.299999237061, 0, 0, 349.99621582031 },
{ 582, -1994.5, -2440.6000976563, 30.799999237061, 0, 0, 349.99609375 },
{ 413, -1999.8000488281, -2435.8000488281, 30.799999237061, 0, 0, 349.99609375 },
{ 440, -1997.3000488281, -2438.3000488281, 30.799999237061, 0, 0, 349.99621582031 },
{ 459, -2005.1999511719, -2430.8000488281, 30.799999237061, 0, 0, 349.99621582031 },
{ 400, -1982.6999511719, -2452, 30.700000762939, 0, 0, 349.99609375 },
{ 442, -1988.0999755859, -2446.8999023438, 30.60000038147, 0, 0, 350 },
{ 482, -2002.5999755859, -2433.1000976563, 30.89999961853, 0, 0, 349.99609375 },
{ 495, -2005.38, -2411.13, 30.62, 0, 0, 183.99609375 },
-- LV INDUS
{ 499, 561.70001220703, 1682, 7.0999999046326, 0, 0, 210 },
{ 588, 550.70001220703, 1673.8000488281, 7, 0, 0, 270 },
{ 403, 561.09997558594, 1652.8000488281, 7.6999998092651, 0, 0, 349.99975585938 },
{ 498, 558.59997558594, 1680.5999755859, 7.1999998092651, 0, 0, 210 },
{ 514, 565, 1648.9000244141, 7.6999998092651, 0, 0, 349.99609375 },
{ 524, 550.20001220703, 1668.9000244141, 8, 0, 0, 270 },
{ 423, 563.70001220703, 1684.5, 7.0999999046326, 0, 0, 210 },
{ 532, 579.90002441406, 1633.6999511719, 8.1000003814697, 0, 0, 350 },
{ 414, 555.70001220703, 1678.5, 7.0999999046326, 0, 0, 210 },
{ 578, 603.59997558594, 1651.0999755859, 7.6999998092651, 0, 0, 65 },
{ 443, 612, 1663.3000488281, 7.8000001907349, 0, 0, 64.995239257813 },
{ 486, 594.79998779297, 1644.5, 7.3000001907349, 0, 0, 65 },
{ 515, 568.099609375, 1642.8994140625, 8.1000003814697, 0, 0, 349.99694824219 },
{ 495, 579, 1694.41, 7.1, 0, 0, 210 },
 -- TRACKTOR { 531, 590.5, 1641.5999755859, 7, 0, 0, 65 },
{ 573, 596.5, 1704.0999755859, 7.1999998092651, 0, 0, 210 },
{ 456, 571.70001220703, 1637.4000244141, 7.1999998092651, 0, 0, 350 },
{ 455, 598.20001220703, 1647.6999511719, 7.5999999046326, 0, 0, 65.997436523438 },
{ 530, 585.09997558594, 1641.3000488281, 6.8000001907349, 0, 0, 65 },
{ 444, 551.40002441406, 1648, 7.6999998092651, 0, 0, 35.998291015625 },
{ 556, 543.90002441406, 1666.6999511719, 7.5, 0, 0, 215.99645996094 },
{ 557, 555.79998779297, 1651.1999511719, 7.0999999046326, 0, 0, 35.998291015625 },
{ 568, 590.09997558594, 1702.0999755859, 7, 0, 0, 209.99835205078 },
{ 552, 576.20001220703, 1691.5, 6.8000001907349, 0, 0, 210 },
{ 431, 606.5, 1655.3000488281, 7.1999998092651, 0, 0, 65 },
{ 438, 588.09997558594, 1699.3000488281, 7.1999998092651, 0, 0, 209.99896240234 },
 -- TOWTRUCK { 525, 579.20001220703, 1693.5, 7, 0, 0, 209.99822998047 },
{ 437, 610.79998779297, 1658.9000244141, 7.1999998092651, 0, 0, 65 },
{ 572, 588.29998779297, 1647, 6.5999999046326, 0, 0, 65 },
{ 582, 582.59997558594, 1695, 7.0999999046326, 0, 0, 210 },
{ 413, 566.09997558594, 1685.4000244141, 7.0999999046326, 0, 0, 209.99926757813 },
{ 440, 568.40002441406, 1686.8000488281, 7.1999998092651, 0, 0, 210 },
{ 459, 571, 1688.1999511719, 7.0999999046326, 0, 0, 209.99926757813 },
{ 400, 593.09997558594, 1702.6999511719, 7.0999999046326, 0, 0, 210 },
{ 442, 585.70001220703, 1697.1999511719, 6.9000000953674, 0, 0, 209.99841308594 },
{ 482, 573.29998779297, 1689.5999755859, 7.1999998092651, 0, 0, 210 },
-- AIRPLANE SHOP LS
{ 417, 2115.6000976563, -2449, 14.39999961853, 0, 0, 87.994995117188 },
{ 519, 2115.1999511719, -2425.6999511719, 14.60000038147, 0, 0, 121.98937988281 },
{ 469, 2087.3000488281, -2473.6999511719, 13.60000038147, 0, 0, 221.99481201172 },
{ 487, 2120.8000488281, -2476.3000488281, 13.800000190735, 0, 0, 121.99499511719 },
{ 488, 2112.6999511719, -2475.1999511719, 13.800000190735, 0, 0, 122 },
{ 548, 2115.8000488281, -2437.1999511719, 15.5, 0, 0, 90 },
{ 593, 2098.3000488281, -2420.1000976563, 14.10000038147, 0, 0, 175.99530029297 },
{ 563, 2115.1000976563, -2460.3000488281, 14.5, 0, 0, 89.99951171875 },
{ 476, 2083.8999023438, -2442.6000976563, 14.699999809265, 0, 0, 221.99035644531 },
{ 511, 2082.1999511719, -2454.1999511719, 15.10000038147, 0, 0, 282 },
{ 512, 2083, -2432.3999023438, 14.199999809265, 0, 0, 221.99468994141 },
{ 513, 2105.1999511719, -2425.1000976563, 14.39999961853, 0, 0, 137.98986816406 },
{ 553, 2084.1999511719, -2419.3000488281, 15.800000190735, 0, 0, 219.990234375 },
-- AIRPLANE SHOP SF
{ 553, -1572, -678, 16.5, 0, 0, 1.99951171875 },
{ 488, -1652.5, -610.09997558594, 14.39999961853, 0, 0, 229.99371337891 },
{ 417, -1631.3000488281, -589.20001220703, 14.39999961853, 0, 0, 217.99536132813 },
{ 511, -1606.6999511719, -672.40002441406, 15.39999961853, 0, 0, 344 },
{ 513, -1592.1999511719, -670.59997558594, 14.89999961853, 0, 0, 355.99645996094 },
{ 469, -1594.9000244141, -579.5, 14.199999809265, 0, 0, 195.99981689453 },
{ 487, -1605.9000244141, -582.79998779297, 14.39999961853, 0, 0, 206 },
{ 548, -1644.1999511719, -598.5, 16, 0, 0, 223.99987792969 },
{ 563, -1617.8000488281, -585.79998779297, 15, 0, 0, 199.99975585938 },
{ 476, -1563.1999511719, -660, 15.300000190735, 0, 0, 60 },
{ 512, -1621.6999511719, -662, 14.800000190735, 0, 0, 322 },
{ 519, -1636.1999511719, -653, 15.60000038147, 0, 0, 321.99938964844 },
{ 593, -1649.6999511719, -640, 14.699999809265, 0, 0, 307.99072265625 },
-- AIRPLANE SHOP LV
{ 593, 1594.3000488281, 1182.6999511719, 11.39999961853, 0, 0, 89.994995117188 },
{ 417, 1566, 1188.8000488281, 10.800000190735, 0, 0, 270 },
{ 469, 1572.5999755859, 1207.5, 10.89999961853, 0, 0, 270 },
{ 487, 1610.3000488281, 1205.3000488281, 11.10000038147, 0, 0, 90 },
{ 488, 1612.0999755859, 1216.0999755859, 11.10000038147, 0, 0, 90 },
{ 548, 1564.5999755859, 1214.0999755859, 12.699999809265, 0, 0, 270 },
{ 563, 1562.9000244141, 1202.5, 11.699999809265, 0, 0, 270 },
{ 476, 1612.5999755859, 1164.4000244141, 15.39999961853, 0, 0, 359.99548339844 },
{ 511, 1562.5999755859, 1174.0999755859, 12.300000190735, 0, 0, 319.99401855469 },
{ 512, 1597.4000244141, 1171.3000488281, 14.89999961853, 0, 0, 271.99963378906 },
{ 513, 1607.8000488281, 1176.4000244141, 15, 0, 0, 181.99481201172 },
{ 519, 1602.5999755859, 1192, 11.800000190735, 0, 0, 359.99499511719 },
{ 553, 1580.5999755859, 1169.8000488281, 13, 0, 0, 43.994750976563 },
-- BIKE SHOP LS
{ 448, 704.20001220703, -521.70001220703, 16, 0, 0, 147.99987792969 },
{ 461, 695.90002441406, -521.79998779297, 16, 0, 0, 147.99987792969 },
{ 462, 698.5, -521.40002441406, 16, 0, 0, 147.99987792969 },
{ 463, 707.09997558594, -521.79998779297, 16, 0, 0, 147.99987792969 },
{ 468, 705.79998779297, -521.70001220703, 16.10000038147, 0, 0, 147.99987792969 },
{ 471, 711.29998779297, -521.5, 15.89999961853, 0, 0, 147.99987792969 },
{ 521, 708.40002441406, -521.59997558594, 16, 0, 0, 147.99987792969 },
{ 522, 709.70001220703, -521.59997558594, 16, 0, 0, 147.99987792969 },
{ 581, 697.29998779297, -521.59997558594, 16, 0, 0, 147.99987792969 },
{ 586, 694.29998779297, -521.59997558594, 15.89999961853, 0, 0, 147.99987792969 },
{ 509, 700.59997558594, -519.59997558594, 15.89999961853, 0, 0, 147.99987792969 },
{ 481, 699.40002441406, -521.5, 15.89999961853, 0, 0, 147.99987792969 },
{ 510, 703.29998779297, -521.59997558594, 16, 0, 0, 147.99987792969 },
-- BIKE SHOP SF
{ 448, -2069, -97.599998474121, 34.799999237061, 0, 0, 303.9970703125 },
{ 461, -2069, -96.300003051758, 34.799999237061, 0, 0, 303.99731445313 },
{ 462, -2069.3000488281, -99, 34.799999237061, 0, 0, 303.99731445313 },
{ 463, -2069.1999511719, -90.199996948242, 34.799999237061, 0, 0, 240 },
{ 468, -2069.1000976563, -86, 34.900001525879, 0, 0, 240 },
{ 471, -2069.3999023438, -100.80000305176, 34.700000762939, 0, 0, 304 },
{ 521, -2069, -88.800003051758, 34.799999237061, 0, 0, 240 },
{ 522, -2069, -87.400001525879, 34.799999237061, 0, 0, 239.99584960938 },
{ 581, -2069.1000976563, -84.800003051758, 34.900001525879, 0, 0, 240 },
{ 586, -2069.3000488281, -83.400001525879, 34.799999237061, 0, 0, 240 },
{ 509, -2070.8000488281, -91.099998474121, 34.799999237061, 0, 0, 303.99731445313 },
{ 481, -2069, -94.099998474121, 34.799999237061, 0, 0, 303.99731445313 },
{ 510, -2068.6999511719, -94.900001525879, 34.900001525879, 0, 0, 303.99725341797 },
-- BIKE SHOP LV
{ 448, 1965.9000244141, 2039.1999511719, 10.699999809265, 0, 0, 137.99987792969 },
{ 461, 1967.3000488281, 2039.1999511719, 10.699999809265, 0, 0, 137.99987792969 },
{ 462, 1964.6999511719, 2039.5999755859, 10.800000190735, 0, 0, 147.99108886719 },
{ 463, 1960.0999755859, 2039.5, 10.699999809265, 0, 0, 137.99987792969 },
{ 468, 1961.5, 2039.5, 10.800000190735, 0, 0, 137.99987792969 },
{ 471, 1962.9000244141, 2039.4000244141, 10.60000038147, 0, 0, 137.99981689453 },
{ 521, 1951.6999511719, 2039.3000488281, 10.699999809265, 0, 0, 137.99987792969 },
{ 522, 1950.1999511719, 2039.3000488281, 10.699999809265, 0, 0, 137.99987792969 },
{ 581, 1956.8000488281, 2039.1999511719, 10.800000190735, 0, 0, 137.99987792969 },
{ 586, 1958.5, 2039.3000488281, 10.699999809265, 0, 0, 137.99987792969 },
{ 509, 1954.1999511719, 2039, 10.699999809265, 0, 0, 137.99987792969 },
{ 481, 1953, 2038.9000244141, 10.699999809265, 0, 0, 137.99987792969 },
{ 510, 1955.5999755859, 2039, 10.800000190735, 0, 0, 137.99987792969 },
-- FAST CAR LS
{  402, 544.29998779297, -1291.1999511719, 17.200000762939 },
{  411, 565.59997558594, -1279.5, 17, 0, 0, 51.999877929688 },
{  415, 568.40002441406, -1289.6999511719, 17.10000038147, 0, 0, 50 },
{  429, 539.90002441406, -1291.6999511719, 17 },
{  451, 536, -1291.5, 17 },
{  477, 553.5, -1291.4000244141, 17.10000038147 },
{  480, 558, -1291.6999511719, 17.10000038147 },
{  506, 561.59997558594, -1291.8000488281, 17 },
{  541, 565.29998779297, -1292, 16.89999961853 },
{  555, 562.59997558594, -1264.3000488281, 17, 0, 0, 51 },
{  558, 566.59997558594, -1284.5999755859, 17, 0, 0, 51.999877929688 },
{  559, 564.79998779297, -1274.1999511719, 17, 0, 0, 51.999877929688 },
{  560, 563.59997558594, -1268.5, 17.10000038147, 0, 0, 50.999755859375 },
{  562, 543.5, -1268.4000244141, 17, 0, 0, 277.99914550781 },
{  565, 547.5, -1265.3000488281, 16.89999961853, 0, 0, 278 },
{  587, 549, -1291.5999755859, 17.10000038147 },
{  602, 552.09997558594, -1262.1999511719, 17.10000038147, 0, 0, 278 },
{  603, 527.20001220703, -1291.3000488281, 17.200000762939 },
{  409, 523.20001220703, -1290.1999511719, 17.200000762939 },
{  494, 531.90002441406, -1291.1999511719, 17.200000762939 },
{  502, 539.29998779297, -1271.8000488281, 17.200000762939, 0, 0, 278 },
--{  503, 534.59997558594, -1275.5, 17.200000762939, 0, 0, 277.998046875 },
{  504, 534.59997558594, -1275.5, 17.200000762939, 0, 0, 278 },
{  424, 531.5, -1278.8000488281, 17.200000762939, 0, 0, 277.998046875 },
{  561, 527.07001220703, -1281.9600244141, 17.10000038147, 0, 0, 277.998046875 },

-- FAST CAR SF
{ 424, -1677.6999511719, 1213.6999511719, 13.5, 0, 0, 180 },
{ 402, -1664.9000244141, 1223.5999755859, 13.60000038147, 0, 0, 92 },
{ 411, -1679.8000488281, 1208.8000488281, 13.5 },
{ 415, -1659.5999755859, 1220.8000488281, 13.5, 0, 0, 133.99761962891 },
{ 429, -1654.9000244141, 1215.8000488281, 13.39999961853, 0, 0, 133.99877929688 },
{ 451, -1652.5999755859, 1212.9000244141, 13.39999961853, 0, 0, 133.99719238281 },
{ 477, -1664.5, 1224.4000244141, 21, 0, 0, 254 },
{ 480, -1671.5999755859, 1204.5999755859, 13.5 },
{ 506, -1675.5, 1205.0999755859, 13.5 },
{ 541, -1649.5, 1210.0999755859, 13.39999961853, 0, 0, 133.99926757813 },
{ 555, -1667.6999511719, 1204.6999511719, 13.5 },
{ 558, -1646.5999755859, 1206.0999755859, 20.89999961853, 0, 0, 6 },
{ 559, -1651, 1213.0999755859, 20.89999961853, 0, 0, 40 },
{ 560, -1667.0999755859, 1205.5, 21, 0, 0, 290 },
{ 562, -1675.9000244141, 1208.3000488281, 20.89999961853, 0, 0, 38 },
{ 565, -1657, 1218.5999755859, 13.39999961853, 0, 0, 133 },
{ 587, -1664.4000244141, 1218.5, 21, 0, 0, 217.99658203125 },
{ 602, -1656.5, 1204.5999755859, 21.10000038147, 0, 0, 80 },
{ 603, -1657, 1218.4000244141, 21.200000762939, 0, 0, 49.999877929688 },
{ 579, -1648.1999511719, 1204.9000244141, 13.800000190735, 0, 0, 100 },
{ 589, -1658.3000488281, 1211.8000488281, 20.89999961853, 0, 0, 185.99938964844 },
{ 494, -1650, 1210.8000488281, 7.1999998092651, 0, 0, 101.99157714844 },
{ 502, -1666.5, 1216.3000488281, 7.1999998092651, 0, 0, 280 },
{ 503, -1655.8000488281, 1216.1999511719, 7.1999998092651, 0, 0, 101.99157714844 },
{ 504, -1653.9000244141, 1213, 7.1999998092651, 0, 0, 101.99633789063 },
-- FAST CAR LV
{ 402, 2107.6000976563, 1409.4000244141, 10.800000190735 },
{ 494, 2107.1999511719, 1397.6999511719, 10.800000190735, 0, 0, 180 },
{ 411, 2113.8999023438, 1409.0999755859, 10.60000038147 },
{ 502, 2152.1999511719, 1397.9000244141, 10.800000190735, 0, 0, 180 },
{ 415, 2120, 1409, 10.699999809265 },
{ 429, 2126.1999511719, 1409, 10.60000038147 },
{ 451, 2132.6000976563, 1409, 10.60000038147 },
{ 477, 2139, 1409.3000488281, 10.699999809265 },
{ 503, 2119.1999511719, 1420.0999755859, 10.800000190735, 0, 0, 219.99572753906 },
{ 480, 2101.1000976563, 1409.1999511719, 10.699999809265 },
{ 506, 2145.3999023438, 1408.8000488281, 10.60000038147 },
{ 477, 2100.8999023438, 1398.1998291016, 10.699999809265, 0, 0, 180 },
{ 541, 2152, 1408.5, 10.5 },
{ 555, 2130.3999023438, 1420.8000488281, 10.60000038147, 0, 0, 219 },
{ 555, 2120.1000976563, 1398.1999511719, 10.60000038147, 0, 0, 180 },
{ 424, 2145.6413574219, 1399.0432128906, 10.699999809265, 0, 0, 180 },
{ 504, 2114.3000488281, 1397.5999755859, 10.800000190735, 0, 0, 180 },
{ 579, 2126.5, 1397.6999511719, 10.89999961853, 0, 0, 180 },
{ 402, 2141.8000488281, 1420.1999511719, 10.800000190735, 0, 0, 219 },
{ 603, 2132.8000488281, 1398.0999755859, 10.800000190735, 0, 0, 180 },
{ 475, 2139.3000488281, 1398, 10.699999809265, 0, 0, 180 },
{ 409, 2125.6000976563, 1419.5, 10.699999809265, 0, 0, 219.99572753906 },
{ 550, 2135.8000488281, 1420.3000488281, 10.699999809265, 0, 0, 219.99572753906 },
{ 558, 2146.8000488281, 1420.6999511719, 10.5, 0, 0, 219.99572753906 },
{ 562, 2129, 1386.4000244141, 10.60000038147, 0, 0, 316 },
{ 565, 2124.6000976563, 1386.0999755859, 10.5, 0, 0, 316 },
{ 559, 2119.6000976563, 1387, 10.60000038147, 0, 0, 316 },
{ 561, 2134, 1386.94, 10.82, 0, 0, 316 }
}

local showroomBoats = { 
-- BOAT SHOP LS
{ 446, -13, -1601.5, 0, 0, 0, 180 },
{ 452, -13.60000038147, -1577.8000488281, 0, 0, 0, 179.99981689453 },
{ 453, -47.299999237061, -1619.1999511719, 0, 0, 0, 178 },
{ 454, -26, -1621.9000244141, 0, 0, 0, 180 },
{ 472, -13.39999961853, -1631.5, 0, 0, 0, 179.99468994141 },
{ 473, -46.799999237061, -1640.0999755859, 0 },
{ 484, -35.200000762939, -1635.4000244141, 0, 0, 0, 180 },
{ 493, -35.5, -1610.3000488281, 0, 0, 0, 180 },
{ 595, -24.39999961853, -1599.5999755859, 0, 0, 0, 178 },
{ 460, -27, -1648, 1.7000000476837, 0, 0, 180 },
{ 539, -46, -1648.9000244141, 0 },
-- BOAT SHOP SF
{ 446, -2224.5, 2401.5, 0, 0, 0, 45.993530273438 },
{ 452, -2230.8000488281, 2448.1000976563, 0, 0, 0, 45.995727539063 },
{ 453, -2240.5, 2439.8999023438, 0, 0, 0, 43.999755859375 },
{ 454, -2249.1000976563, 2428.1999511719, 0, 0, 0, 43.995239257813 },
{ 472, -2210.3000488281, 2408.6999511719, 0, 0, 0, 46 },
{ 473, -2217.6999511719, 2416.5, 0, 0, 0, 46.000122070313 },
{ 484, -2202.3000488281, 2421.3999023438, 0, 0, 0, 45.99560546875 },
{ 493, -2232.8000488281, 2392.3999023438, 0, 0, 0, 43.996826171875 },
{ 595, -2259.6000976563, 2419.8999023438, 0.89999997615814, 0, 0, 45.9990234375 },
{ 460, -2220.3994140625, 2415.7998046875, 1.7999999523163, 0, 0, 46 },
{ 539, -2238, 2405.5, 0, 0, 0, 316 },
-- BOAT SHOP LV
{ 446, 2345.1000976563, 486.89999389648, 0.69999998807907, 0, 0, 269.99548339844 },
{ 452, 2359.5, 504.89999389648, 0.20000000298023, 0, 0, 1.9952392578125 },
{ 453, 2319.1999511719, 506.20001220703, 0 },
{ 454, 2331.6000976563, 506.5, 0 },
{ 472, 2347, 508.20001220703, 0 },
{ 473, 2287.8999023438, 497.79998779297, 0, 0, 0, 180 },
{ 484, 2298.3000488281, 487.89999389648, 0, 0, 0, 269.99560546875 },
{ 493, 2323.8000488281, 487.5, 0, 0, 0, 270 },
{ 595, 2287.5, 511.29998779297, 0, 0, 0, 180 },
{ 539, 2310.6000976563, 499.29998779297, 1, 0, 0, 272 },
{ 460, 2302.1999511719, 509.29998779297, 2 }
}


-- Make them
for ID=1,#showroomVehicles do 
	local vehicleID = showroomVehicles[ID][1]
	local x, y, z = showroomVehicles[ID][2], showroomVehicles[ID][3], showroomVehicles[ID][4]
	local rotation = showroomVehicles[ID][7]
	local theVehicle = createVehicle ( vehicleID, x, y, z, 0, 0, rotation )
	
	setTimer( setElementFrozen, 3000, 1, theVehicle, true )
	setElementData ( theVehicle, "showRoomVehicle", true )	
end

for ID=1,#showroomBoats do 
	local vehicleID = showroomBoats[ID][1]
	local x, y, z = showroomBoats[ID][2], showroomBoats[ID][3], showroomBoats[ID][4]
	local rotation = showroomBoats[ID][7]
	local theVehicle = createVehicle ( vehicleID, x, y, z, 0 +1.1, 0, rotation )
	
	setTimer( setElementFrozen, 3000, 1, theVehicle, true )
	setElementData ( theVehicle, "showRoomVehicle", true )
end