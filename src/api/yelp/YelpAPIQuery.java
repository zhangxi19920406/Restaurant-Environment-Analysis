package api.yelp;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;

public class YelpAPIQuery {

	private static final String[] DEFAULT_LOCATION_ZIP_CODE = { "10026", "10027", "10030", "10037", "10039", "10001",
			"10011", "10018", "10019", "10020", "10036", "10029", "10035", "10010", "10016", "10017", "10022", "10012",
			"10013", "10014", "10004", "10005", "10006", "10007", "10038", "10280", "10002", "10003", "10009", "10021",
			"10028", "10044", "10065", "10075", "10128", "10023", "10024", "10025", "10031", "10032", "10033", "10034",
			"10040" };
	private static final String[] DEFAULT_CATEGORY_FILTER = { "chinese", "italian", "newamerican", "mexican",
			"tradamerican", "japanese", "latin", "indpak", "thai", "french", "turkish", "african", "greek" };

	/*
	 * Update OAuth credentials below from the Yelp Developers API site:
	 * http://www.yelp.com/developers/getting_started/api_access
	 */
	private static final String CONSUMER_KEY = "e09hMhRZVoTC3sIz-6rx4w";
	private static final String CONSUMER_SECRET = "2DrvTE889yMnvmmA2lo9I59a_WU";
	private static final String TOKEN = "o2a1G3tmobRNl9lKLizEhEQA6D03tckg";
	private static final String TOKEN_SECRET = "4AFzgUZB_bAvrBLBQn-JHjaWQhU";

	private static class YelpAPICLI {

		private static final String DEFAULT_TERM = "food";
		private static final String DEFAULT_LOCATION = "Manhattan";

		@Parameter(names = { "-q", "--term" }, description = "Search Query Term")
		public String term = DEFAULT_TERM;

		@Parameter(names = { "-l", "--location" }, description = "Location to be Queried")
		public String location = DEFAULT_LOCATION;

		@Parameter(names = { "-cf", "--category_filter" }, description = "Location to be Queried")
		public String category_filter = "";
	}

	public void query(String filepath) {
		YelpAPICLI yelpApiCli = new YelpAPICLI();
		YelpAPI yelpApi = new YelpAPI(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET);
		for (String zipcode : DEFAULT_LOCATION_ZIP_CODE) {
			yelpApiCli.location = zipcode;
			for (String category_filter : DEFAULT_CATEGORY_FILTER) {
				yelpApiCli.category_filter = category_filter;
				new JCommander(yelpApiCli, new String[] {});
				queryAPI(yelpApi, yelpApiCli, filepath);
			}
		}
		System.out.println("Finished!");
	}

	/**
	 * Queries the Search API based on the command line arguments and takes the
	 * first result to query the Business API.
	 * 
	 * @param yelpApi
	 *            service instance
	 * @param yelpApiCli
	 *            command line arguments
	 */
	private void queryAPI(YelpAPI yelpApi, YelpAPICLI yelpApiCli, String filepath) {
		int offset = 0;
		int total = Integer.MAX_VALUE;
		while (offset < total) {
			// Request JSON data
			String searchResponseJSON = yelpApi.searchForBusinessesByLocation(offset, yelpApiCli.term,
					yelpApiCli.category_filter, yelpApiCli.location);
			JSONParser parser = new JSONParser();
			JSONObject response = null;
			try {
				response = (JSONObject) parser.parse(searchResponseJSON);
			} catch (ParseException pe) {
				System.out.println("Error: could not parse JSON response:");
				System.out.println(searchResponseJSON);
				System.exit(1);
			}
			try {
				total = new Integer(response.get("total").toString());
			} catch (Exception e) {
				System.out.println(e);
				continue;
			}
			total = new Integer(response.get("total").toString());
			offset += 20;

			if (!response.containsKey("businesses")) {
				System.out.println(response.toJSONString());
				break;
			}
			JSONArray businesses = (JSONArray) response.get("businesses");

			for (int i = 0; i < businesses.size(); i++) {
				JSONObject business = (JSONObject) businesses.get(i);
				writeJSONToFile(filepath + "/YELPAPI.json", business.toJSONString() + "\r\n");
			}
			if (offset >= 1000) {
				break;
			}
			if (offset % 100 == 0) {
				System.out.println(offset);
			}

		}
		System.out.println(yelpApiCli.term + ", " + yelpApiCli.category_filter + ", " + yelpApiCli.location + ": "
				+ total + " queried");
	}

	private void writeJSONToFile(String filepath, String content) {
		BufferedWriter fileWriter = null;
		try {
			File file = new File(filepath);
			if (!file.exists()) {
				file.createNewFile();
			}
			fileWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, true)));
			fileWriter.write(content);
			fileWriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				fileWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
