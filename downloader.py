# -*- coding: utf-8 -*-
from __future__ import print_function
import concurrent.futures
import requests
import shutil
import imghdr
import os

""" Download image according to given urls and automatically rename them in order. """

__author__ = "Yabin Zheng ( sczhengyabin@hotmail.com )"


headers = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Proxy-Connection": "keep-alive",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                  "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36",
    "Accept-Encoding": "gzip, deflate, sdch",
    # 'Connection': 'close',
}


def download_image(image_url, dst_dir, file_name, timeout=20, proxy_type=None, proxy=None):
    proxies = None
    if proxy_type is not None:
        proxies = {
            "http": proxy_type + "://" + proxy,
            "https": proxy_type + "://" + proxy
        }
    r = None
    file_path = os.path.join(dst_dir, file_name)
    try:
        r = requests.get(image_url, headers=headers, timeout=timeout, proxies=proxies)
        with open(file_path, 'wb') as f:
            f.write(r.content)
        r.close()
        file_type = imghdr.what(file_path)
        if file_type is not None:
            new_file_name = "{}.{}".format(file_name, file_type)
            new_file_path = os.path.join(dst_dir, new_file_name)
            shutil.move(file_path, new_file_path)
            print("## OK:  {}  {}".format(new_file_name, image_url))
        else:
            os.remove(file_path)
            print("## Err:  {}".format(image_url))
    except Exception as e:
        if r:
            r.close()
        print("## Fail:  {}  {}".format(image_url, e.args))


def download_images(image_urls, dst_dir, file_prefix="img", concurrency=50, timeout=20, proxy_type=None, proxy=None):
    """
    Download image according to given urls and automatically rename them in order.
    :param timeout:
    :param proxy:
    :param proxy_type:
    :param image_urls: list of image urls
    :param dst_dir: output the downloaded images to dst_dir
    :param file_prefix: if set to "img", files will be in format "img_xxx.jpg"
    :param concurrency: number of requests process simultaneously
    :return: none
    """

    with concurrent.futures.ThreadPoolExecutor(max_workers=concurrency) as executor:
        futures = list()
        count = 0
        if not os.path.exists(dst_dir):
            os.makedirs(dst_dir)
        for image_url in image_urls:
            file_name = file_prefix + "_" + "%03d" % count
            futures.append(executor.submit(
                download_image, image_url, dst_dir, file_name, timeout, proxy_type, proxy))
            count += 1
