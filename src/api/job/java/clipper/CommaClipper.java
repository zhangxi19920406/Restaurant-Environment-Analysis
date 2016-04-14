package clipper;

import java.io.*;

public class CommaClipper {
	private static String source;
	
	public CommaClipper(String str){
		source = str;
	}
	
	public static boolean IsNullOrEmpty(String str){
		if(str == null)
			return true;
		else if(str == "")
			return true;
		else
			return false;
	}
	
	public static String trimComma(){
		if (IsNullOrEmpty(source))
        {
            return source;
        }
        char[] array = source.toCharArray();
        int len = array.length;
        int index = 0;
        StringBuilder builder = new StringBuilder();
        while (index < len)
        {
            while (index < len && !(array[index] == '"'))
            {
                builder.append(array[index]);
                index++;
            }
            int squoteCount = 0;
            while (index < len && (array[index] == '"'))
            {
                builder.append(array[index]);
                squoteCount++;
                index++;
            }
            int start = index;
            while (index < len && !(array[index] == '"'))
            {
                builder.append(array[index]);
                index++;
            }
            int equoteCount = 0;
            while (index < len && (array[index] == '"'))
            {
                builder.append(array[index]);
                equoteCount++;
                index++;
            }
            int end = index;
            if (squoteCount > 0 && squoteCount == equoteCount)
            {
                int pos = start;
                while (pos < end)
                {
                    if (array[pos] == ',')
                    {
                        array[pos] = '#';
                    }
                    pos++;
                }
            }
        }
        String cc = new String(array);
        return cc.replace("#", "");
	}
}
