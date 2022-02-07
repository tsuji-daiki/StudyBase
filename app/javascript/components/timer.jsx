import React,{Fragment, useState, useRef, useEffect, useCallback} from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'


const CountUpTimer = () => {
  const [time, setTime] = useState({
    hour: 0,
    minute: 0,
    second: 0
  }); //設定時間

  const [retime, setRetime] = useState({
    hour: 0,
    minute: 0,
    second: 0
  }) //残り時間


  useEffect(() => {
    console.log(retime.hour)
    console.log(retime.minute)
    console.log(retime.second)
    console.log("retimeの値が変更されました")
  },[retime])

  const changeTimerHour = (e) => {
    const value = e.target.value;
    const replaced = value.replace(/^0+/,'') //valueの先頭0を正規表現で削除
    setTime({
      ...time, 
      hour:parseInt(replaced,10)||0
    })
  }

  const changeTimerMinute = (e) => {
    const value = e.target.value;
    const replaced = value.replace(/^0+/,'')
    setTime({
      ...time, 
      minute:parseInt(replaced,10)||0
    })
  }

  const settingCount = () => {
    setRetime({
      ...retime,
      hour:time.hour,
      minute:time.minute,
      second:time.second
    })
  }

  const countDownStart = () => {
    setInterval(() => {
      if(retime.hour === 0 && retime.minute === 0 && retime.second === 0){
        setRetime({
          ...retime, 
          hour:time.hour, 
          minute:time.minute, 
          second:time.second
        })
      } else if (retime.minute === 0 && retime.second === 0) {
        setRetime( prevCount => {
          const newCountDownHour = prevCount.hour - 1
          return {
            ...retime, 
            hour: newCountDownHour, 
            minute: 59, 
            second: 59
          }
        })
      } else if (retime.second === 0) {
        setRetime( prevCount => {
          const newCountDownMinute = prevCount.minute - 1
          return {
            ...retime, 
            hour: retime.hour, 
            minute: newCountDownMinute, 
            second: 59
          }
        })
      } else {
        setRetime( prevCount => {
          const newCountDownSecond = prevCount.second - 1
          return {
            ...retime, 
            hour:retime.hour, 
            minute:retime.minute, 
            second:newCountDownSecond
          }
        })
      }
    },1000)
  }

  return(
    <Fragment>
      <div>
        <p>{retime.hour}</p>
        <p>{retime.minute}</p>
        <p>{retime.second}</p>
      </div>
      <p>目標勉強時間を入力してください</p>
      <input type="text" value={time.hour} onChange={changeTimerHour}></input>
      <input type="text" value={time.minute} onChange={changeTimerMinute}></input>
      <button onClick={settingCount}>時間を設定</button>
      <button onClick={countDownStart}>勉強開始</button>
  </Fragment>
  )
}

// CountUpTimer.defaultProps = {
//   name: 'Daiki'
// }

// CountUpTimer.propTypes = {
//   name: PropTypes.string
// }

export default CountUpTimer