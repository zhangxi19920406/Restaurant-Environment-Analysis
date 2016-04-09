package main;

import java.io.IOException;

import api.yelp.YelpAPIQuery;
import api.yelp.reformat.Reformat;
import api.yelp.reformat.ReformatType;

public class Main {

	private static final String ARGUMENT_YELP_API = "yelp";
	private static final String ARGUMENT_YELP_REFORMAT = "yelpreformat";
	private static final String ARGUMENT_YELP_CSV = "yelpcsv";

	public static void main(String[] args) {
		// Argument for get yelp data : yelp [file path]
		if (yelpAPIArgument(args)) {
			YelpAPIQuery yelpAPIQuery = new YelpAPIQuery();
			System.out.println("Filepath:" + args[1]);
			yelpAPIQuery.query(args[1]);
		} else if (yelpReformat(args)) { // Argument for reformat yelp data :
											// yelpreformat [file path] [file
											// path]
			try {
				Reformat.reformat(args[1], args[2]);
			} catch (IllegalArgumentException | ClassNotFoundException | IOException | InterruptedException e) {
				e.printStackTrace();
			}
		} else if (yelpCSV(args)) { // Argument for reformat yelp data :
									// yelpcsv [file path] [file path]
			ReformatType.transformToCVS(args[1], args[2]);
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

	/**
	 * Check the whether the system argument is to use the reformat yelp API
	 * output.
	 * 
	 * @param args
	 *            the system argument
	 * @return whether the system argument is to reformat yelp API output
	 */
	private static boolean yelpReformat(String[] args) {
		if (args.length != 3 || !args[0].equalsIgnoreCase(ARGUMENT_YELP_REFORMAT)) {
			return false;
		}
		return true;
	}

	/**
	 * Check the whether the system argument is to use the reformat yelp API
	 * into csv.
	 * 
	 * @param args
	 *            the system argument
	 * @return whether the system argument is to reformat yelp API output
	 */
	private static boolean yelpCSV(String[] args) {
		if (args.length != 3 || !args[0].equalsIgnoreCase(ARGUMENT_YELP_CSV)) {
			return false;
		}
		return true;
	}

}
