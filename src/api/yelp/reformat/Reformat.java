package api.yelp.reformat;

import java.io.IOException;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import main.Main;

public class Reformat {

	public static void reformat(String inputPath, String outputPath)
			throws IllegalArgumentException, IOException, ClassNotFoundException, InterruptedException {

		@SuppressWarnings("deprecation")
		Job job = new Job();
		job.setJarByClass(Main.class);
		job.setJobName("Yelp Reformat");

		FileInputFormat.addInputPath(job, new Path(inputPath));
		FileOutputFormat.setOutputPath(job, new Path(outputPath));

		job.setMapperClass(ReformatMapper.class);
		job.setReducerClass(ReformatReducer.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);

		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
