package api.yelp.reformat;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.json.JSONException;
import org.json.JSONObject;

public class ReformatMapper extends Mapper<LongWritable, Text, Text, Text> {

	private static final String[] USELESS_TAG = new String[] { "url", "menu_date_updated", "phone", "menu_provider",
			"is_closed", "display_phone", "mobile_url", "image_url", "rating_img_url", "rating_img_url_large",
			"rating_img_url_small", "snippet_image_url", "snippet_text" };

	@Override
	public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		try {
			String line = value.toString();
			JSONObject obj = new JSONObject(line);
			if ((boolean) obj.get("is_closed")) {
				return;
			}
			String id = obj.getString("id");
			for (int i = 0; i < USELESS_TAG.length; i++)
				if (obj.has(USELESS_TAG[i])) {
					obj.remove(USELESS_TAG[i]);
				}
			context.write(new Text(id), new Text(obj.toString()));
		} catch (JSONException e) {
			e.printStackTrace();
		}

	}
}
