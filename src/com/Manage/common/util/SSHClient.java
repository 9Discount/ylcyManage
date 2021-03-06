package com.Manage.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;

public class SSHClient {

	public static String LinuxComm(String host,int port,String username,String password,String comm) {
		String reString="";
		//指明连接主机的IP地址
		Connection conn = new Connection(host,port);
		Session ssh = null;
		try {
			//连接到主机
			conn.connect();
			//使用用户名和密码校验
			boolean isconn = conn.authenticateWithPassword(username, password);
			if(!isconn){
				System.out.println("用户名称或者是密码不正确");
			}else{
				System.out.println("已经连接OK");
				ssh = conn.openSession();
				//使用多个命令用分号隔开
//				ssh.execCommand("pwd;cd /tmp;mkdir hb;ls;ps -ef|grep weblogic");
				ssh.execCommand(comm);
				//只允许使用一行命令，即ssh对象只能使用一次execCommand这个方法，多次使用则会出现异常
//				ssh.execCommand("mkdir hb");
				//将屏幕上的文字全部打印出来
				InputStream  is = new StreamGobbler(ssh.getStdout());
				BufferedReader brs = new BufferedReader(new InputStreamReader(is));
				int temp=0;
				while(true){
					String line = brs.readLine();
					if(line==null){
						break;
					}
					if(temp>0){
						reString+="@"+line;
					}else{
						reString+=line;
					}
					
					temp++;
				}
				System.out.println(reString);
				return reString;
			}
			//连接的Session和Connection对象都需要关闭
			ssh.close();
			conn.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(reString);
		return reString;
	}

}
