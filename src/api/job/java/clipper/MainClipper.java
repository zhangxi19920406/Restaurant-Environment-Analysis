package clipper;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.FileWriter;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class MainClipper {
	public static void main(String[] args){
		if (args.length != 1) {
			System.err.println("Usage: MainClipper <input file name>");
			System.exit(-1);
		}
		try{
			  File file = new File("output.txt");
			  FileInputStream fstream = new FileInputStream(args[0]);
			  FileWriter fw = new FileWriter(file);
			  BufferedWriter writer =  new BufferedWriter(fw);
			  DataInputStream in = new DataInputStream(fstream);
			  BufferedReader br = new BufferedReader(new InputStreamReader(in));
			  String strLine;
			  while ((strLine = br.readLine()) != null) {
				  CommaClipper clipper =  new CommaClipper(strLine);
				  String nstr = clipper.trimComma();
				  SpaceClipper clipper2 = new SpaceClipper(nstr);
				  String nstr2 = clipper2.trimSpace();
				  writer.write(nstr2);
				  writer.newLine();
			  }
			  in.close();
			  writer.close();
			    }catch (Exception e){//Catch exception if any
			  System.err.println("Error: " + e.getMessage());
			  }
		
	}
}
