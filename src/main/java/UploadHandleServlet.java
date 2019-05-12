import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@SuppressWarnings("serial")
public class UploadHandleServlet extends HttpServlet {
	private Logger logger;
	private Logger loggerCsv;
	private String year;
	private String month;
	private String date;
	private File directory;
	private File directoryLog;
	private String logpath;
	private String cmdPath;
	private HashMap<String, String> user;

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();

		Calendar c = Calendar.getInstance();// 可以对每个时间域单独修改
		year = String.valueOf(c.get(Calendar.YEAR));
		month = String.valueOf(c.get(Calendar.MONTH) + 1);
		date = String.valueOf(c.get(Calendar.DATE));

		logger = Logger.getLogger("");
		loggerCsv = Logger.getLogger("");
		try {
			FileHandler filehander = new FileHandler(year + month + date + "receive.log", true);
			logger.addHandler(filehander);
			logger.log(Level.INFO, "初始化中");
			SimpleFormatter sf = new SimpleFormatter();
			filehander.setFormatter(sf);
			FileHandler filehanderCsv = new FileHandler(year + month + date + ".csv", true);
			logger.addHandler(filehanderCsv);
			filehanderCsv.setFormatter(sf);
			loggerCsv.log(Level.INFO, "初始化中");
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		directory = new File("Print/Document/Primary");
		if (!directory.exists()) {
			directory.mkdirs();
			logger.log(Level.INFO, "新建文件夹：" + directory.getPath() + "\n" + directory.getAbsolutePath());
		}
		directoryLog = new File("Print/Document/Log");
		if (!directoryLog.exists()) {
			directoryLog.mkdirs();
			logger.log(Level.INFO, "新建文件夹：" + directory.getPath() + "\n" + directory.getAbsolutePath());
		}

		logpath = directoryLog.getAbsolutePath() + File.separatorChar + String.valueOf(year) + String.valueOf(month + 1)
				+ String.valueOf(date) + ".txt";
		cmdPath = directoryLog.getAbsolutePath() + File.separatorChar + "cmdPath" + String.valueOf(year)
				+ String.valueOf(month + 1) + String.valueOf(date) + ".txt";
		
		//下面这种硬编码的方式非常不好，应该采用读取xml文件配置的方式解决

		String[][] cupb = { { "123456", "cupb01#admin" }, { "18010472947", "cupb01#傲寒宏志" },
				{ "13121189359", "cupb01#熊平" }, { "15210585715", "cupb01#路登省" }, { "18175306923", "cupb01#秦时明月" },
				{ "15210063301", "cupb01#黄修林" }, { "13161082250", "cupb01#汪涛岩" }, { "13691183379", "cupb01#裴孝东" }, 
				{ "15210013163", "cupb01#马超" } ,{ "13121175253", "cupb01#路元昊" },{ "13001120900", "cupb01#文晨宇" },{"15010367378","cupb01#杨大海"}};
		user = new HashMap<String,String>();
		for (int i = 0; i < cupb.length; i++) {
			user.put(cupb[i][0], cupb[i][1]);
		}
		
		user.put("15811018509", "cupb01#赵双全");
		user.put("13121188712", "cupb01#张飞羽");
		user.put("18813033532", "cupb01#卢泽龙");
		user.put("15210002232", "cupb01#刘成");
	//	user.put("17801171017", "cupb01#刘伟");
		user.put("13126693211", "cupb01#郭景全");
		user.put("001", "cupb01#姚江南");
		user.put("15600539855", "cupb01#孙贺");
		user.put("002", "cupb01#张辉");
		user.put("15600555077", "cupb01#王宇");
		user.put("18674163920", "cupb01#关帅");
		user.put("15289137237", "cupb01#益西");
		user.put("13126695155", "cupb01#桑珠");
		user.put("15010071198", "cupb01#贾伟");
		user.put("13121188539", "cupb01#崔杰奇");
		user.put("13121197352", "cupb01#沙锋");
		String[][] jliae01 = {{"17726211360", "jliae01#绿林"},{"123", "jliae01#不排队"},{"13364059134","jliae01#杨元媛"},{"15310255626","jliae01#李佳星"}};
		for (int i = 0; i < jliae01.length; i++) {
			user.put(jliae01[i][0], jliae01[i][1]);
		}
		user.put("123", "jliae01#adm");

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
		// String savePath = this.getServletContext().getRealPath("/WEB-INF/upload");
		// 新建文件夹，存放接受的文件

		String shop = null;
		// 日志：

		String savePath = directory.getAbsolutePath();
		// 消息提示
		String message = "";
		String UserName = "";
		String telephone = null;
		String cmd = "";
		FileWriter fw = null;
		BufferedWriter bw = null;
		FileWriter fw2 = null;
		BufferedWriter bw2 = null;
		String path = null;
		String path1 = null;
		String path2 = null;
		String path3 = null;

		boolean Enable = false;

		File file1 = new File(logpath);
		if (!file1.exists()) {
			file1.getParentFile().mkdirs();
			file1.createNewFile();
		}
		fw = new FileWriter(file1, true);
		bw = new BufferedWriter(fw);
		bw.write("日志：" + System.getProperty("line.separator"));

		File file2 = new File(cmdPath);
		if (!file2.exists()) {
			file2.getParentFile().mkdirs();
			file2.createNewFile();
		}
		fw2 = new FileWriter(file2, true);
		bw2 = new BufferedWriter(fw2);
		// bw2.write("cmdPath：" + System.getProperty("line.separator"));

		try {
			// 使用Apache文件上传组件处理文件上传步骤：
			// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			if (!ServletFileUpload.isMultipartContent(request)) {
				// 按照传统方式获取数据
				return;
			}

			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			@SuppressWarnings("unchecked")
			List<FileItem> list = upload.parseRequest(request);
			StringBuffer msg = new StringBuffer();

			for (FileItem item : list) {

				// 如果fileitem中封装的是普通输入项的数据
				// System.out.println("名字："+item.getName());

				if (item.isFormField()) {
					String name = item.getFieldName();
					// 解决普通输入项的数据的中文乱码问题
					String value = item.getString("UTF-8");
					// System.out.println(name + "=" + value);
					if (name.trim().equals("username") && value.trim().equals("")) {
						UserName = "大圣！生死簿上没有你的名字呀。";
						System.out.println("用户没有提供姓名");

						break;
					} else if (name.trim().equals("username") && value != "") {
						// message = "hello! " + value + "。";
						UserName = value.trim();
						msg.append("用户名：" + value + "，");
						Date day = new Date();

						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						cmd = df.format(day) + "#" + value;
						System.out.println("\n\n上传时间：" + df.format(day));
						System.out.println("用户姓名：" + value);
						bw.write("上传时间：" + df.format(day) + System.getProperty("line.separator"));
						bw.write("用户姓名：" + value + System.getProperty("line.separator"));

					} else if (name.trim().equals("telephone") && value != "") {
						bw.write("电话号码是：" + value + System.getProperty("line.separator"));

						// 依据电话号码，再查找值与
						String nameAndSchool = null;
						if ((nameAndSchool = user.get(value.trim())) != null) {
							String[] ns = nameAndSchool.split("#");
							if (ns[1].trim().equals(UserName)) {
								if ("cupb01".equals(ns[0].trim())) {
									shop = "cupb01";
									logger.log(Level.INFO, "");
								} else if ("jliae01".equals(ns[0].trim())) {
									shop = "jliae01";
									logger.log(Level.INFO, "");
								} else
									;
							} else {
								logger.log(Level.INFO, "");
								message = message + "你没有申请打印权限，申请联系QQ3227556776";
							}
						} else {
							logger.log(Level.INFO, "");
							System.out.println("非法用户");
							bw.write("非法用户" + System.getProperty("line.separator"));
							message = message + "你的电话号码有误，联系QQ3227556776";
							break;
						}

						/*
						 * if (user.get(UserName) != null) { if (!user.get(UserName).equals(value)) {
						 * System.out.println("非法用户"); bw.write("非法用户" +
						 * System.getProperty("line.separator")); message = message +
						 * "你的电话号码有误，联系QQ3227556776"; break; } } else { message = message +
						 * "你没有申请打印权限，申请联系QQ3227556776"; break; }
						 */
						telephone = value.trim();
						System.out.println("电话号码是：" + value);
						logger.log(Level.INFO, "");
					}
					// value = new String(value.getBytes("iso8859-1"),"UTF-8");
					else if (name.trim().equals("shuangmian") && value.trim().equals("shuangmian")) {
						// System.out.println("选择双面打印");
						cmd = cmd + "#" + value;
						msg.append("打印方式：双面，");
						System.out.print("打印方式：双面，");
						logger.log(Level.INFO, "");
						bw.write("打印方式：双面，");
					} else if (name.trim().equals("shuangmian") && value.trim().equals("danmian")) {
						cmd = cmd + "#" + value;
						msg.append("打印方式：单面，");
						logger.log(Level.INFO, "");
						bw.write("打印方式：单面，");
						System.out.print("打印方式：单面，");
					} else if (name.trim().equals("heyi") && value.trim().equals("baheyi")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("八合一");
						System.out.print("八合一，");
						bw.write("八合一，");
					} else if (name.trim().equals("heyi") && value.trim().equals("yiheyi")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("一合一");
						System.out.print("一合一，");
						bw.write("一合一，");
					} else if (name.trim().equals("heyi") && value.trim().equals("liuheyi")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("六合一");
						System.out.print("六合一，");
						bw.write("六合一，");
					} else if (name.trim().equals("copies") && value.trim().equals("one")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("1份");
						System.out.println("1份\n");
						bw.write("1份" + System.getProperty("line.separator") + System.getProperty("line.separator"));
					} else if (name.trim().equals("copies") && value.trim().equals("two")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("2份");
						System.out.println("2份\n");
						bw.write("2份" + System.getProperty("line.separator") + System.getProperty("line.separator"));
					} else if (name.trim().equals("copies") && value.trim().equals("three")) {
						// 双面打印
						cmd = cmd + "#" + value;
						msg.append("3份");
						System.out.println("3份\n");
						bw.write("3份" + System.getProperty("line.separator") + System.getProperty("line.separator"));
					}
				}
				// 上传文件处理
				else {
					// 如果fileitem中封装的是上传文件
					// 得到上传的文件名称，
					String filename = item.getName();
					// System.out.println("文件名：" + filename);
					// msg.append("文件名是：" + filename);
					// bw.write("文件名是：" + filename + System.getProperty("line.separator"));
					String filename2 = filename.toLowerCase();
					if (filename == null || filename.trim().equals("")) {
						// message = message + "打印失败，没有提交文件！";
						continue;// 不可以是break，因为可以提交多个文件

					} else if (filename2.contains("doc") || filename2.contains("docx") || filename2.contains("pdf")
							|| filename2.contains("ppt") || filename2.contains("pptx")) {

						// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如： c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						// System.out.println("初始文件名：" + filename);
						filename = filename.substring(filename.lastIndexOf("/") + 1);
						// System.out.println("之后文件名：" + filename);
						// System.out.println("文档路径：" + savePath + "\\" + filename);
						String pathname = savePath + File.separatorChar + filename;
						File fileExist = new File(pathname);
						if (fileExist.exists()) {// 判断文件是否已经存在，为了防止覆盖，所以新建文件名
							UUID uuid = UUID.randomUUID();// 全球唯一标识码
							String newEnd = String.valueOf(uuid).substring(0, 3);
							// System.out.println("唯一标识：" + uuid + "\n开头" + newEnd);
							String name = filename.substring(0, filename.lastIndexOf("."));// get file name without
																							// suffix name.
							String suffix = filename.substring(filename.lastIndexOf("."));
							pathname = savePath + File.separatorChar + name + newEnd + suffix;
						} else
							;
						// 获取item中的上传文件的输入流
						InputStream in = item.getInputStream();
						try {
							// 创建一个文件输出流
							FileOutputStream out = new FileOutputStream(pathname);
							// 创建一个缓冲区
							byte buffer[] = new byte[1024];
							// 判断输入流中的数据是否已经读完的标识
							int len = 0;
							// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
							while ((len = in.read(buffer)) > 0) {
								// 使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
								out.write(buffer, 0, len);
							}
							// 关闭输入流
							in.close();
							// 关闭输出流
							out.close();
							// 删除处理文件上传时生成的临时文件
							item.delete();
							bw.write("文档路径：" + pathname + System.getProperty("line.separator"));
							System.out.println("文档路径：" + pathname);
							if (path == null) {
								path = pathname;
							} else
								path = path + "#" + pathname;// 多文件
							if (path1 == null) {
								path1 = pathname;
							} else if (path2 == null) {
								path2 = pathname;
							} else if (path3 == null) {
								path3 = pathname;
							}

							Enable = true;
						} catch (FileNotFoundException e) {
							Enable = false;
							e.printStackTrace();
							message = message + "请求的操作无法在使用用户映射区域打开的文件上执行。";
							logger.log(Level.INFO, "请求的操作无法在使用用户映射区域打开的文件上执行。");
							// 该问题的原因是因为，java打印线程一直占用了该文件，又没有关闭。所以采用新建线程的办法解决了
						}
					} else
						message = message + "你的文件中含有不可以打印的，自动过滤了。";
					;
				}
			}

			if (Enable) {
				boolean backCode = false;
				ExecutorService es = Executors.newCachedThreadPool();
				if (shop != null) {
					java.util.concurrent.Future<Boolean> future = es.submit(new MyRunnable(shop, path, cmd));
					backCode = future.get();
				}

				if (backCode == true) {
					message = message + "文件上传成功，正在打印！";
					logger.log(Level.INFO, "文件上传成功，正在打印！");
				} else {
					logger.log(Level.INFO, "打印失败，服务器故障！正在恢复中...");
					message = message + "打印失败，服务器故障！正在恢复中...";
				}

				String omd = UserName + "," + telephone + "," + path + "," + cmd;

				loggerCsv.log(Level.INFO, omd);
			} else {
				bw.write("非法操作！" + System.getProperty("line.separator"));

				message = message + "温馨提示：请检查姓名，权限，文件格式。";
				logger.log(Level.INFO, "非法操作！");
			}
			bw.flush();

		} catch (Exception e) {
			logger.log(Level.INFO, "文件上传超时，网络不稳定，请重新上传。");
			bw.write("文件上传超时，网络不稳定，请重新上传。" + System.getProperty("line.separator"));
			message = "文件上传超时，网络不稳定，请重新上传。";
			e.printStackTrace();

		} finally {
			try {
				if (bw != null) {
					bw.close();
				}
				if (fw != null) {
					fw.close();
				}
				if (bw2 != null) {
					bw2.close();
				}
				if (fw2 != null) {
					fw2.close();
				}

			} catch (NullPointerException e) {
				logger.log(Level.INFO, "NullPointerException");
			}

		}

		// System.out.println(row.getPhysicalNumberOfCells() + " " +
		// row.getLastCellNum());

		request.setAttribute("message", message);
		request.setAttribute("name", UserName);
		// String path = request.getContextPath();// 获取当前项目的跟路径
		// System.out.println(path);
		request.getRequestDispatcher("/message.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	 public void destroy() {
		    // 终止化代码...
		  }

}

class MyRunnable implements Callable<Boolean> {
	String path;
	String cmd;
	Logger logger;
	String shop;

	MyRunnable(String shop, String path, String cmd) {

		logger = Logger.getLogger("");
		try {
			FileHandler filehander = new FileHandler("delivery.log", true);
			logger.addHandler(filehander);
			logger.log(Level.INFO, "文件信息：" + path);
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.path = path;
		this.cmd = cmd;
		this.shop = shop;

	}

	public Boolean call() throws Exception {
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket("127.0.0.1", 8899);
			dos = new DataOutputStream(socket.getOutputStream());
			// 只用传输文件地址和用户指令即可！
			dos.writeUTF(shop);
			dos.flush();
			dos.writeUTF(cmd);
			dos.flush();
			dos.writeUTF(path);
			dos.flush();
			return true;

		} catch (Exception e) {
			logger.log(Level.INFO, "接收线程崩溃！");
			return false;
		} finally {
			try {
				if (dos != null) {
					dos.close();
					System.out.println("dos关闭");
				}
				if (socket != null) {
					socket.close();
				}

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
