#!/bin/bash

usage() {
	echo "Usage: $0 [-e] [-i <file path>]" 1>&2;
	exit 2; 
}

# 渲染模式配置文件
RENDER_PLIST_FILE=".xcodesamplecode.plist"
# 渲染模式配置内容
RENDER_PLIST_CONTENT="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<array/>
</plist>"


ARGS=`getopt ei: $*`

if [ $? != 0 ]
then
	echo parse arguments fail!
	usage
fi

if [[ $# == 0 ]]; then
	echo empty arguments!
	usage
fi

# echo ARGS=[$ARGS]
eval set -- "${ARGS}"

if [[ $# -eq 1 ]]; then
	usage
fi

EDIT_ENABLE=false;
while true
do
	case "$1" in
		-e)
			EDIT_ENABLE=true;
            shift
            ;;
        -i)
            XCODE_PROJECT_DIR="$2"; shift;
            shift
            ;;
        --)
	        shift
	        break;
	        ;;
	    *)
			usage
			;;
    esac
done


# xcode工程 & 存在
if [[ -d $XCODE_PROJECT_DIR ]]; then
	NAME=`basename $XCODE_PROJECT_DIR`
	if [[ "${NAME##*.}" != 'xcodeproj' ]]; then
		echo "xcode工程格式不正确"
		exit 1
	fi

	echo XCODE_PROJECT_DIR is "$XCODE_PROJECT_DIR"

	SAMPLE_PLIST="${XCODE_PROJECT_DIR}/${RENDER_PLIST_FILE}"
	if $EDIT_ENABLE; then
		# 编辑模式
		echo "ENTER EDIT MODE"	
		if [[ -f $SAMPLE_PLIST ]]; then
			`rm "$SAMPLE_PLIST"`
		fi
	else
		# 预览模式
		echo "ENTER PREVIEW MODE"
		if [[ -ne $SAMPLE_PLIST ]]; then
			`touch "$SAMPLE_PLIST"`
			`echo "$RENDER_PLIST_CONTENT" > "$SAMPLE_PLIST"`
		fi
	fi
else
	echo "xcode工程不存在"
	exit 1
fi
