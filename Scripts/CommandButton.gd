extends Control

func init(image, text):
	$image.texture = image
	$Text.text = text
	return self
