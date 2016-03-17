package mian;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;

import api.yelp.YelpAPI;

public class Main {
	
	private static final String DEFAULT_TERM = "dinner";
	private static final String DEFAULT_LOCATION = "New York, NY";

	/*
	 * Update OAuth credentials below from the Yelp Developers API site:
	 * http://www.yelp.com/developers/getting_started/api_access
	 */
	private static final String CONSUMER_KEY = "e09hMhRZVoTC3sIz-6rx4w";
	private static final String CONSUMER_SECRET = "2DrvTE889yMnvmmA2lo9I59a_WU";
	private static final String TOKEN = "o2a1G3tmobRNl9lKLizEhEQA6D03tckg";
	private static final String TOKEN_SECRET = "4AFzgUZB_bAvrBLBQn-JHjaWQhU";

	public static void main(String[] args) {
		YelpAPICLI yelpApiCli = new YelpAPICLI();
		new JCommander(yelpApiCli, args);

		YelpAPI yelpApi = new YelpAPI(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET);
		queryAPI(yelpApi, yelpApiCli);
	}
	
	/**
	 * Command-line interface for the sample Yelp API runner.
	 */
	private static class YelpAPICLI {
		@Parameter(names = { "-q", "--term" }, description = "Search Query Term")
		public String term = DEFAULT_TERM;

		@Parameter(names = { "-l", "--location" }, description = "Location to be Queried")
		public String location = DEFAULT_LOCATION;
	}
	
	/**
	 * Queries the Search API based on the command line arguments and takes the
	 * first result to query the Business API.
	 * 
	 * @param yelpApi
	 *            <tt>YelpAPI</tt> service instance
	 * @param yelpApiCli
	 *            <tt>YelpAPICLI</tt> command line arguments
	 */
	private static void queryAPI(YelpAPI yelpApi, YelpAPICLI yelpApiCli) {
		String searchResponseJSON = yelpApi.searchForBusinessesByLocation(yelpApiCli.term, yelpApiCli.location);

		JSONParser parser = new JSONParser();
		JSONObject response = null;
		try {
			response = (JSONObject) parser.parse(searchResponseJSON);
		} catch (ParseException pe) {
			System.out.println("Error: could not parse JSON response:");
			System.out.println(searchResponseJSON);
			System.exit(1);
		}
		System.out.println(searchResponseJSON);
		JSONArray businesses = (JSONArray) response.get("businesses");
		JSONObject firstBusiness = (JSONObject) businesses.get(0);
		String firstBusinessID = firstBusiness.get("id").toString();
		System.out.println(String.format("%s businesses found, querying business info for the top result \"%s\" ...",
				businesses.size(), firstBusinessID));

		// Select the first business and display business details
		String businessResponseJSON = yelpApi.searchByBusinessId(firstBusinessID.toString());
		System.out.println(String.format("Result for business \"%s\" found:", firstBusinessID));
		System.out.println(businessResponseJSON);
	}

}
