package api.yelp.reformat;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ReformatType {

	public static void transformToCVS(String input, String output) {
		BufferedReader bufferedReader = null;
		BufferedWriter bufferedWriter = null;
		try {
			File inputFile = new File(input);
			if (!inputFile.exists()) {
				System.err.println("Input file not exist!");
				return;
			}
			FileReader fileReader = new FileReader(input);
			bufferedReader = new BufferedReader(fileReader);
			File outputFile = new File(output);
			if (outputFile.exists()) {
				outputFile.delete();
			}
			outputFile.createNewFile();
			FileWriter fileWriter = new FileWriter(outputFile);
			bufferedWriter = new BufferedWriter(fileWriter);
			String line = bufferedReader.readLine();
			// Every line data format
			// id,postal_code,geo_accuracy,latitude,longitude,categories,rating
			while (line != null) {
				JSONObject jsonObject = new JSONObject(line.trim());
				StringBuilder sb = new StringBuilder();
				sb = sb.append(jsonObject.getString("id")).append(",");
				JSONObject location = jsonObject.getJSONObject("location");
				if (!location.has("postal_code")) {
					line = bufferedReader.readLine();
					continue;
				}
				sb = sb.append(location.getString("postal_code")).append(",").append(location.getDouble("geo_accuracy"))
						.append(",");
				JSONObject coordinate = location.getJSONObject("coordinate");
				sb = sb.append(coordinate.getDouble("latitude")).append(",").append(coordinate.getDouble("longitude"))
						.append(",");
				JSONArray categories = jsonObject.getJSONArray("categories");
				sb = sb.append(categories.getJSONArray(0).getString(0)).append(",");
				sb = sb.append(jsonObject.getDouble("rating"));
				bufferedWriter.write(sb.toString());
				bufferedWriter.newLine();
				line = bufferedReader.readLine();
			}
			System.out.println("Finished!");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			try {
				bufferedReader.close();
				bufferedWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
