package api.job.udf;

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

@Description(name = "MyToTime", value = "returns date, which is of hive date type ", extended = "SELECT myToTime('date') from foo limit 1;")
class MyToTime extends UDF {

	public Text evaluate(Text input) {
		if (input == null)
			return null;
		else {
			String str = input.toString();
			String[] strs = str.split("/");
			String nstr = String.format("%s-%s-%s", strs[2], strs[0], strs[1]);
			return new Text(nstr);
		}
	}
}