package mian;

import api.yelp.YelpAPIQuery;

public class Main {

	private static final String ARGUMENT_YELP_API = "yelp";

	public static void main(String[] args) {
		// Argument for get yelp data : yelp
		if (yelpAPIArgument(args)) {
			YelpAPIQuery yelpAPIQuery = new YelpAPIQuery();
			System.out.println("Filepath:" + args[1]);
			yelpAPIQuery.query(args[1]);
		} else {
			System.out.println("Wrong arguments");
		}
	}

	/**
	 * Check the whether the system argument is to use the yelp API.
	 * 
	 * @param args
	 *            the system argument
	 * @return whether the system argument is to get yelp API
	 */
	private static boolean yelpAPIArgument(String[] args) {
		return (args.length == 2 && args[0].equalsIgnoreCase(ARGUMENT_YELP_API));
	}

}
