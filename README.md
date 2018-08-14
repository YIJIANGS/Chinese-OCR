# Chinese-OCR
Chinese OCR with HOG + SVM

run wd_segmentation_diff_size.m to see result.

Although Chinese OCR is similar to digit recognition, the scale of the problem is different. For digit recognition, only ten classes need to be categorized, whereas for Chinese OCR, I have implemented an algorithm that could classify up to 500 words(Although I have downloaded over 900 Chinese characters with different fonts, it becomes incrementally difficult when increasing the number of classes, so the maximum number of classes in my experiment is only 500). The task of this algorithm is to train a number of known fonts (if I train 50 fonts with 100 words, it means I have 100 classes and 50 samples for each class in training set) and make prediction on new fonts which is not inside the trained fonts.

I have obtained data by manually copying and pasting a set of Chinese words(1000 common words) onto a website http://www.fonts.net.cn/fonts-zh-1.html and this will output the same words with different fonts in image. 


I have used 45 different fonts in total. The image has very clear white background and black Chinese words, which makes it easily segmented. I have first binarized the image by forcing the word region to be one(one is displayed as white colour) and the background to be zero(displayed as black in binary image). Then I calculate the histogram of vertical direction pixels, from this step, I get the vertical index of all elements so I know where each row of words are and what is their pixel height. Let’s say I have the vertical index [3,4,5,6,9,10,11,12,...], I know the first row of words appear in line 3 to line 6 and 2nd row is from 9 to 12 etc.

HOG is a good approach for character recognition. Since it operates on local cells, it is invariant to geometric and photometric transformations, except for object orientation. For the case of Chinese OCR,  object orientation is not a factor to be considered(all images are in the right orientation), however geometric transformation is important in our classification problem. Therefore, it is likely to produce a good result.

For each word image, I first resize the image to 30*30 pixels and binarize the gray-scaled image( binary image is somehow better than gray image in test result) using a global threshold(calculated through global histogram). Then I extract HOG features from each image using a cell size 8*8, in Matlab, the command is extractHOGFeatures(). The final form of HOG feature descriptors are  n*m*144, where n is the number of training classes and m is number of fonts used(training samples for each class).

These features are then trained using support vector machine(SVM), the command for this is fitcecoc(), and fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
