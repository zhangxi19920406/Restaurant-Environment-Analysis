package api.job.java.clipper;

public class SpaceClipper {
	private static String source;

	public SpaceClipper(String str) {
		source = str;
	}

	public static boolean IsNullOrEmpty(String str) {
		if (str == null)
			return true;
		else if (str == "")
			return true;
		else
			return false;
	}

	public String trimSpace() {
		if (IsNullOrEmpty(source)) {
			return source;
		}
		String result = "";
		String[] strs = source.split(",");
		int index = 0;
		for (String st : strs) {
			result = result.concat(st.trim());
			index++;
			if (index != strs.length)
				result = result.concat(",");
		}
		return result;
	}
}
