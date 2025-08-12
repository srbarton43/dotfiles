function latest_screenshot
  find ~/Pictures -type f -name "*grim*" -print0 | xargs -0 ls -t | head -1
end
