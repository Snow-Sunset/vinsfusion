#!/bin/bash
# OpenCV 3到OpenCV 4的批量替换脚本
# 用于VINS-Fusion项目

# 确保在vinsfusion_ws/src/vinsfusion目录下运行
if [ ! -d ".git" ]; then
    echo "错误：请在VINS-Fusion项目根目录下运行此脚本"
    exit 1
fi

# 备份原始文件（仅执行一次）
BACKUP_DIR="opencv3_backup"
if [ ! -d "$BACKUP_DIR" ]; then
    echo "正在创建文件备份..."
    mkdir -p "$BACKUP_DIR"
    find . -name "*.cpp" -o -name "*.h" -o -name "CMakeLists.txt" | xargs -I {} cp --parents {} "$BACKUP_DIR"
    echo "备份完成！文件保存在 $BACKUP_DIR 目录"
fi

# 1. 更新所有CMakeLists.txt中的OpenCV路径
echo "正在更新CMakeLists.txt中的OpenCV路径..."
find . -name "CMakeLists.txt" -exec sed -i 's|set(OpenCV_DIR "~/opencv/opencv-3.4.12/build")|set(OpenCV_DIR "~/opencv/opencv/build")|g' {}\;

# 2. 处理常见的API变更

# 2.1 处理cv::findChessboardCorners标志参数变化
echo "正在更新cv::findChessboardCorners标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CALIB_CB_ADAPTIVE_THRESH|cv::CALIB_CB_ADAPTIVE_THRESH|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CALIB_CB_NORMALIZE_IMAGE|cv::CALIB_CB_NORMALIZE_IMAGE|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CALIB_CB_FILTER_QUADS|cv::CALIB_CB_FILTER_QUADS|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CALIB_CB_FAST_CHECK|cv::CALIB_CB_FAST_CHECK|g' {}\;

# 2.2 处理加载图像标志
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_LOAD_IMAGE_GRAYSCALE|cv::IMREAD_GRAYSCALE|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_LOAD_IMAGE_COLOR|cv::IMREAD_COLOR|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_LOAD_IMAGE_UNCHANGED|cv::IMREAD_UNCHANGED|g' {}\;

# 2.3 处理窗口相关标志
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_WINDOW_AUTOSIZE|cv::WINDOW_AUTOSIZE|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_WINDOW_NORMAL|cv::WINDOW_NORMAL|g' {}\;

# 2.4 处理颜色转换标志
echo "正在更新颜色转换标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_BGR2GRAY|cv::COLOR_BGR2GRAY|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_GRAY2BGR|cv::COLOR_GRAY2BGR|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_BGR2RGB|cv::COLOR_BGR2RGB|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_RGB2BGR|cv::COLOR_RGB2BGR|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_GRAY2RGB|cv::COLOR_GRAY2RGB|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_RGB2GRAY|cv::COLOR_RGB2GRAY|g' {}\;

# 2.5 处理绘制标志
echo "正在更新绘制标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_AA|cv::LINE_AA|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FILLED|cv::FILLED|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_LINE_4|cv::LINE_4|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_LINE_8|cv::LINE_8|g' {}\;

# 2.6 处理特征检测参数
echo "正在更新特征检测参数..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FAST_FEATURE_DETECTOR_THRESHOLD|cv::FastFeatureDetector::THRESHOLD|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FAST_FEATURE_DETECTOR_NONMAX_SUPPRESSION|cv::FastFeatureDetector::NONMAX_SUPPRESSION|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FAST_FEATURE_DETECTOR_TYPE_5_8|cv::FastFeatureDetector::TYPE_5_8|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FAST_FEATURE_DETECTOR_TYPE_7_12|cv::FastFeatureDetector::TYPE_7_12|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_FAST_FEATURE_DETECTOR_TYPE_9_16|cv::FastFeatureDetector::TYPE_9_16|g' {}\;

# 2.7 处理数据类型标志
# 注意：这些通常保持不变，但为了完整性添加
# 数据类型常量在OpenCV 4中通常保持不变

# 2.8 处理阈值相关标志
echo "正在更新阈值相关标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_THRESH_BINARY|cv::THRESH_BINARY|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_THRESH_BINARY_INV|cv::THRESH_BINARY_INV|g' {}\;

# 2.9 处理形态学操作标志
echo "正在更新形态学操作标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_SHAPE_CROSS|cv::MORPH_CROSS|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_SHAPE_RECT|cv::MORPH_RECT|g' {}\;

# 2.10 处理轮廓检测标志
echo "正在更新轮廓检测标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_RETR_CCOMP|cv::RETR_CCOMP|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CHAIN_APPROX_SIMPLE|cv::CHAIN_APPROX_SIMPLE|g' {}\;

# 2.11 处理颜色常量
echo "正在更新颜色常量..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_RGB(\([0-9]*\),\([0-9]*\),\([0-9]*\))|cv::Scalar(\1, \2, \3)|g' {}\;

# 2.12 处理TermCriteria相关标志
# 注意：CV_TERMCRIT_EPS + CV_TERMCRIT_ITER 需要特殊处理
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|cv::TermCriteria(CV_TERMCRIT_EPS + CV_TERMCRIT_ITER|cv::TermCriteria(cv::TermCriteria::EPS + cv::TermCriteria::MAX_ITER|g' {}\;

# 2.8 处理其他常用标志
echo "正在更新其他常用标志..."
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_TERMCRIT_ITER|cv::TermCriteria::MAX_ITER|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_TERMCRIT_EPS|cv::TermCriteria::EPS|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_INTER_LINEAR|cv::INTER_LINEAR|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_INTER_NEAREST|cv::INTER_NEAREST|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_INTER_CUBIC|cv::INTER_CUBIC|g' {}\;

# 3. 处理VideoCapture相关变更
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CAP_PROP_FRAME_WIDTH|cv::CAP_PROP_FRAME_WIDTH|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CAP_PROP_FRAME_HEIGHT|cv::CAP_PROP_FRAME_HEIGHT|g' {}\;
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|CV_CAP_PROP_FPS|cv::CAP_PROP_FPS|g' {}\;

# 4. 添加额外的OpenCV头文件包含（如果需要）
echo "正在检查并添加必要的OpenCV头文件..."
# 这里可以添加针对特定文件的头文件添加逻辑

# 5. 特殊情况处理
# 处理CV_Assert，这个在OpenCV 4中通常保持不变，但如果有编译错误可能需要检查
echo "正在检查特殊情况..."

# 6. 清理可能的错误替换
echo "正在清理可能的错误替换..."
# 移除可能的重复cv::前缀
find . -type f -name "*.cpp" -o -name "*.h" -exec sed -i 's|cv::cv::|cv::|g' {}\;

# 5. 创建一个帮助文档，列出可能需要手动检查的地方
cat > opencv4_migration_notes.md << EOF
# VINS-Fusion OpenCV 4 迁移注意事项

## 已自动处理的内容
- 更新了所有CMakeLists.txt中的OpenCV路径
- 替换了常见的标志常量前缀（CV_* 到 cv::*）
- 更新了图像加载和窗口标志
- 更新了颜色转换标志（如cv::COLOR_BGR2GRAY -> cv::COLOR_BGR2GRAY）
- 更新了绘制标志（如CV_AA -> cv::LINE_AA）
- 更新了特征检测参数
- 更新了其他常用OpenCV标志

## 需要手动检查的内容

1. **SFM模块兼容性问题**
   - OpenCV 4中的SFM模块可能与Ceres版本不兼容
   - 如遇到ceres::SubsetManifold相关错误，可考虑禁用SFM模块
   - 添加 \`-D BUILD_opencv_sfm=OFF\` 到CMake配置选项

2. **其他可能的API变更**
   - 某些函数签名或行为在OpenCV 4中可能已改变
   - 请关注编译错误，根据具体错误信息进行调整

3. **头文件包含**
   - 某些组件可能需要额外包含特定的头文件

4. **特定模块迁移**
   - 一些在OpenCV 3中存在的模块可能在OpenCV 4中被移动或重命名
   - 例如：contrib模块中的一些功能

## 编译建议
1. 使用 \`catkin_make_isolated\` 而不是 \`catkin_make\` 来处理非catkin包
2. 如遇到编译错误，先检查具体错误信息，再针对性解决
3. 可以考虑使用ccmake或cmake-gui查看和调整CMake配置

## 常见编译错误及解决方案
- **找不到头文件错误**：检查是否需要添加额外的头文件包含
- **未定义的引用错误**：可能是因为某个模块没有正确链接，检查CMakeLists.txt
- **函数签名不匹配**：需要手动更新函数调用以匹配新的API
EOF

echo "脚本执行完成！"
echo "请查看 opencv4_migration_notes.md 获取详细迁移指南"
echo "建议在编译前先检查代码中的关键部分"