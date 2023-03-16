package br.com.newgo.appcargo.locationserver.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

	@GetMapping("/exoplayer/com/transistorsoft/tsbackgroundfetch/maven-metadata.xml")
	public void mavenMetadata(HttpServletResponse response) throws MalformedURLException, IOException {

		BufferedInputStream in = new BufferedInputStream(new URL(
				"https://raw.githubusercontent.com/transistorsoft/flutter_background_fetch/master/android/libs/com/transistorsoft/tsbackgroundfetch/maven-metadata.xml")
						.openStream());
		IOUtils.copy(in, response.getOutputStream());

	}

}
