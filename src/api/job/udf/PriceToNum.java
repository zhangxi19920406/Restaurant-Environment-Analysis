package api.job.udf;

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.DoubleWritable;

@Description(name = "PriceToNum", value = "returns price, which is of hive double type ", extended = "SELECT PriceToNum('price') from foo limit 1;")
class PriceToNum extends UDF {

	public DoubleWritable evaluate(Text input) {
		if (input == null)
			return null;
		else {
			String str = input.toString();
			if (str.startsWith("$")) {
				String nstr = str.substring(1);
				double price = Double.parseDouble(nstr);
				return new DoubleWritable(price);
			} else
				return new DoubleWritable(0.0);
		}
	}
}