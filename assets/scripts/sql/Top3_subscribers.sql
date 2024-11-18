/* 

# 1. Define variables 
# 2. Create a CTE that rounds the average views per video 
# 3. Select the column you need and create calculated columns from existing ones 
# 4. Filter results by Youtube channels
# 5. Sort results by net profits (from highest to lowest)

*/


-- 1. 
DECLARE @conversionRate FLOAT = 0.02;		-- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;		-- The product cost @ $5
DECLARE @campaignCost MONEY = 50000.0;		-- The campaign cost @ $50,000	
DECLARE @numberOfVideos INT = 11;               -- The number of videos (11)
DECLARE @campaignCostPerVideo FLOAT = 5000.0;   -- The campaign cost per video @ $5,000
DECLARE @campaignCostM MONEY = 130000.0;	-- The campaign cost @ $130,000

-- 2.  
WITH ChannelData AS (
    SELECT 
        channel_name,
		total_subscribers,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_uk_youtubers_2024
)
-- 3.
SELECT TOP 3
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit_product_placement,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - (@campaignCostPerVideo * @numberOfVideos) AS net_profit_sponsored_video_series,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCostM AS net_profit_Influencer_marketing
    
FROM 
    ChannelData

-- 4. 
-- 5.  
ORDER BY
	total_subscribers DESC